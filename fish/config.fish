if status is-interactive
    # turn off fish greetings
    set -g fish_greeting

    # turn on fish vi bindings
    fish_vi_key_bindings

    # make nix with with fish
    # any-nix-shell fish --info-right | source

    alias vi="/usr/local/bin/nvim"

    abbr -a j jump
    abbr -a x exit
    abbr -a cdu cd-gitroot
    abbr -a o xdg-open
    abbr -a spot "alacritty -e ncspot &"
    abbr -a nv neovide
    abbr -a pnpmci "pnpm install --frozen-lockfile"

    # turn on direnv
    direnv hook fish | source

    # turn off dir underlining: https://unix.stackexchange.com/questions/272629/how-to-stop-fish-shell-from-underlining-path
    set fish_color_valid_path

    # stop the locale problem with nix and vscode: https://www.reddit.com/r/NixOS/comments/oj4kmd/comment/h4zjrj5/
    # export LC_ALL=

    set -x PATH $PATH ~/local/bin ~/.cargo/bin

    # if not test "$TERM_PROGRAM" = "tmux"
    #     exec tmux
    # end
end

