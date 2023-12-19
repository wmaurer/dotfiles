if status is-interactive
    # turn off fish greetings
    set -g fish_greeting

    # turn on fish vi bindings
    fish_vi_key_bindings

    # make nix with with fish
    any-nix-shell fish --info-right | source

    alias vi = "/usr/local/bin/nvim"
    alias x = "exit"

    # turn on direnv
    direnv hook fish | source

    # stop the locale problem with nix and vscode: https://www.reddit.com/r/NixOS/comments/oj4kmd/comment/h4zjrj5/
    # export LC_ALL=

    set -x PATH $PATH ~/local/bin ~/.cargo/bin

    if not set -q TMUX
        exec tmux
    end
end

