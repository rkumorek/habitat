function fish_prompt --description 'Write out the prompt'
    echo -n -s ' ' (set_color normal) (prompt_pwd) ' ' (string repeat -n $SHLVL '>') ' '
end

