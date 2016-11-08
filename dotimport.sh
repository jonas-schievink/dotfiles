#!/usr/bin/env bash

set -o nounset -o errexit

function usage() {
    echo "$0 <name> <path>"
    echo ""
    echo 'Import dotfiles from $HOME.'
    exit 1
}

if [ -z "${1:-}" ]; then
    usage
fi

if [ -z "${2:-}" ]; then
    usage
fi

# Name of new dotfile import
dotname=$1
imprt=$2

# Imported path must exist
if [ ! -e "$imprt" ]; then
    echo "✕ »$imprt« does not exist"
    exit 1
fi

# Reject weird file types / double imports
if [ ! -d "$imprt" ]; then
    if [ ! -f "$imprt" ]; then
        echo "✕ »$imprt« is neither a regular file nor a directory"
        echo ""
        echo "Is this file already imported?"
        exit 1
    fi
fi

# Get path of this script
selfpath=$(readlink -f "$0")
# Dotfiles base dir
dotpath=$(dirname "$selfpath")

# First, make sure the git repo is clean
if [[ -n $(cd "$dotpath"; git status --porcelain) ]]; then
    echo "✕ Dotfiles repository »$dotpath« is dirty"
    echo ""
    echo "Commit or stash the changes first"
#    exit 1
fi

# Abs. path to import
path=$(realpath "$imprt")

# Require the imported path to be in $HOME
if [[ $path != $HOME* ]]; then
    echo "✕ Cannot import from non-home directory »$path«"
    exit 1
fi

# Strip home directory from the path
relpath=${path#$HOME/}

echo "→ Importing »$relpath«..."
target="$dotpath/$dotname/$relpath"

# Create the parent directory
parentdir=$(dirname "$target")
mkdir -p "$parentdir"

cp -ri "$path" "$target"

echo "→ Removing old files..."
rm -r "$path"

echo "→ Linking new dotfiles back..."
stow -d "$dotpath" "$dotname"

echo "→ Creating commit..."
(cd "$dotpath" && git add "$target" && git commit -m "Autoimport $dotname files")

