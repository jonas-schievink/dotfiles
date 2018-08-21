function pip
    if contains "install" $argv
        if not contains -- "--user" $argv
            echo "`pip install` without `--user` denied. Use `pacman` to install system packages instead!"
            return 1
        end
    end

    command pip $argv
end

