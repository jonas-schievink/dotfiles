function intel
    set suffixes "®" "™" "🖕"
    set raw_words "intel" $argv

    for word in $raw_words
        # grab random suffix
        set suffix (string split " " "$suffixes" | shuf | head -1)
        set word (string upper (string sub -l1 "$word"))(string sub -s2 "$word")
        set words $words "$word$suffix"
    end

    echo "$words"
end
