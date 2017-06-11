function pacaur
    if [ "$argv[1]" = "-R" ]
        command pacaur --color=always -Rsc $argv[2..-1]
    else
        command pacaur --color=always $argv
    end
end

