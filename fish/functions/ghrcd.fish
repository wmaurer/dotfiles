function ghrcd -d "gh repo clone with dir"
    set parts (string split / $argv)
    if not test -d $parts[1]
        mkdir $parts[1]
    end
    cd $parts[1]
    gh repo clone $argv
    cd $parts[2]
end
