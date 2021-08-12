function fish_prompt --description 'Write out the prompt'
    echo -n -s ' ' (string repeat -n $SHLVL '>') ' ' (set_color normal) (prompt_pwd) ' ' 
end

