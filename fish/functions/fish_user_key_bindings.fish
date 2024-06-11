function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char # bind ctrl-f to autocomplete
        bind -M $mode \cl forward-word 
	    bind -M $mode \cd delete-char # stop fish exiting on ctrl-d
	    bind -M $mode \cd\cd\cd delete-or-exit # extit on third one
    end
end
