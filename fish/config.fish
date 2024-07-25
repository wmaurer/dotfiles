if status is-interactive
    # turn off fish greetings
    set -g fish_greeting

    # turn on fish vi bindings
    fish_vi_key_bindings

    # make nix with with fish
    # any-nix-shell fish --info-right | source

    if test -f /usr/bin/nvim 
        alias vi="/usr/bin/nvim"
    else if test -f /usr/local/bin/nvim 
        alias vi="/usr/local/bin/nvim"
    end

    abbr -a j jump
    abbr -a x exit
    abbr -a cdu cd-gitroot
    abbr -a o xdg-open
    abbr -a spot "alacritty -e ncspot &"
    abbr -a pnpmci "pnpm install --frozen-lockfile"
    abbr -a ghrc "gh repo clone"
    abbr -a dui lazydocker
    abbr -a nv "neovide &; disown"
    abbr -a reset-nvim "rm -rf .local/share/nvim/ .local/state/nvim/ .cache/nvim/"

    # turn on direnv
    direnv hook fish | source

    # turn off dir underlining: https://unix.stackexchange.com/questions/272629/how-to-stop-fish-shell-from-underlining-path
    set fish_color_valid_path

    set --universal nvm_default_version v22

    # stop the locale problem with nix and vscode: https://www.reddit.com/r/NixOS/comments/oj4kmd/comment/h4zjrj5/
    # export LC_ALL=

    set -x PATH $PATH ~/local/bin ~/.cargo/bin ~/.humanlog/bin

    source "$HOME/.cargo/env.fish"

    # if not test "$TERM_PROGRAM" = "tmux"
    #     exec tmux
    # end
end

