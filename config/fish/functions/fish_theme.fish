function fish_theme -a action
    switch $action
        case init
            if not set -q __FISH_THEME
                set -U __FISH_THEME dark
                __set_fish_colors
            else
                if test $SHLVL = 1
                    __fish_alacritty_theme
                end
            end
        case light dark
            set -U __FISH_THEME $action
    end
end

function __fish_color_theme_changed -v __FISH_THEME
    if test $BAT_THEME != gruvbox-$__FISH_THEME
        set -x BAT_THEME gruvbox-$__FISH_THEME
    end

    __fish_alacritty_theme
end

function __fish_alacritty_theme
    if test $TERM = alacritty
        set -l dir (dirname (status -f))
        alacritty msg -s $ALACRITTY_SOCKET config "colors=$(cat $dir/../../alacritty/gruvbox_$__FISH_THEME.yml)" -w $ALACRITTY_WINDOW_ID
    end
end

function __set_fish_colors
    function __set_cv -a var -a col
        if not set -q -U $var
            if test $$var != $col
                set -U $var $col
            end
        end
    end

    __set_cv fish_color_normal                'brwhite'
    __set_cv fish_color_command               'green --bold'
    __set_cv fish_color_keyword               'brblue --bold'
    __set_cv fish_color_quote                 'yellow'
    __set_cv fish_color_redirection           'blue'
    __set_cv fish_color_end                   'blue'
    __set_cv fish_color_error                 'red'
    __set_cv fish_color_param                 'normal'
    __set_cv fish_color_valid_path            '--underline'
    __set_cv fish_color_option                'normal'
    __set_cv fish_color_comment               'white --italics'
    __set_cv fish_color_selection             'normal --background brblack'
    __set_cv fish_color_operator              'blue'
    __set_cv fish_color_escape                'magenta'
    __set_cv fish_color_autosuggestion        'white'
    __set_cv fish_color_cwd                   'normal'
    __set_cv fish_color_cwd_root              'normal'
    __set_cv fish_color_user                  'normal'
    __set_cv fish_color_host                  'normal'
    __set_cv fish_color_host_remote           'normal'
    __set_cv fish_color_status                'normal'
    __set_cv fish_color_cancel                '-r'
    __set_cv fish_pager_color_progress        'normal'
    __set_cv fish_pager_color_prefix          'normal --bold'
    __set_cv fish_pager_color_completion      'normal --underline'
    __set_cv fish_pager_color_description     'normal'
end
