# My Dotfiles

Looks like you've found my dotfiles, or I forgot how they work.

They're managed with [GNU Stow](https://www.gnu.org/software/stow/), so I clone
them into `~/dotfiles` and run something like `stow fish` inside it to "install"
a set of files.

Each directory contains a set of dotfiles that can be installed together:

* `fish`: My [fish](https://github.com/fish-shell/fish-shell) configuration.
  Pretty uninteresting.
* `init-desktop`: Starts scripts and programs after X11 was launched.
* `retroarch`: RetroArch config. Updated mostly automatically via the GUI.
* `runsteam`: A small script and `.desktop` file for running Steam as the
  `steam` user.
* `sway`: [Sway](https://github.com/SirCmpwn/sway/) config. I don't use Wayland
  yet, but I'd like to move to it soon™.
* `systemd-user`: This contains a few unit files run via the user instance of
  systemd.
* `termite`: [Termite](https://github.com/thestinger/termite/) configuration and
  color scheme.
* `vim`: My `vimrc`, located in `~/.config/vim/vimrc` to unclutter `$HOME`
  (the `.vimrc` location is overridden by the `xsession` env vars).
* `xsession`: Contains a `.xsession` script to be run when any X session is started.

