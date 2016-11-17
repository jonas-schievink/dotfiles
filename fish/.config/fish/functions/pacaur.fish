function pacaur
    if [ "$argv[1]" = "-R" ]
        command pacaur -Rsc $argv[2..-1]
    else
        command pacaur $argv
    end
end

