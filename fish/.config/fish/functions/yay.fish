function yay
    if [ "$argv[1]" = "-R" ]
        command yay -Rsc $argv[2..-1]
    else
        command yay $argv
    end
end

