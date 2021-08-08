function fish_theme -a action
    switch $action
        case 'init'
            if set -q fish_color_theme_is_dark
                return 1
            end
            switch $BAT_THEME
                case 'gruvbox-light'
                    __fish_theme_variables light
                    __fish_theme_set_fish_colors light
                case '*'
                    __fish_theme_variables dark
                    __fish_theme_set_fish_colors dark
                    if test $SHLVL -eq 1
                        theme_gruvbox dark medium
                    end
            end
        case 'toggle'
            if test $fish_color_theme_is_dark = 1
                theme_gruvbox light medium
                __fish_theme_set_fish_colors light
                __fish_theme_variables light
            else
                theme_gruvbox dark medium
                __fish_theme_set_fish_colors dark
                __fish_theme_variables dark
            end
    end
end

function __fish_theme_variables -a mode
    switch $mode
        case 'dark'
            set -gx BAT_THEME gruvbox-dark
            set -g fish_color_theme_is_dark 1
        case 'light'
            set -gx BAT_THEME gruvbox-light
            set -g fish_color_theme_is_dark 0
    end
end

function __fish_theme_set_fish_colors -a mode
    switch $mode
        case 'light'
            ## red
            set -g fish_color_error                 9d0006
            ## blue
            set -g fish_color_param                 076678
            set -g fish_color_cwd                   076678
            ## green
            set -g fish_color_command               79740e
            set -g fish_color_user                  79740e
            ## yellow
            set -g fish_color_search_match          bryellow --background=brblack
            set -g fish_color_history_current       yellow --bold
            ## purple
            set -g fish_color_operator              8f3f71
            set -g fish_color_escape                8f3f71
            set -g fish_color_cwd_root              8f3f71
            ## aqua
            set -g fish_color_end                   427b58
            set -g fish_color_redirection           427b58
            ## fg
            set -g fish_color_normal                3c3836
            set -g fish_color_host                  3c3836
            set -g fish_pager_color_completion      3c3836
            set -g fish_color_comment               928374
            set -g fish_color_autosuggestion        928374
            set -g fish_color_valid_path            --underline
            set -g fish_pager_color_prefix          3c3836 --bold --underline
            set -g fish_color_selection             3c3836 --bold --background=928374
            set -g fish_pager_color_progress        3c3836 --bold --background=928374
            set -g fish_pager_color_description     B3A06D yellow
            set -g fish_color_cancel                -r
            ## orange
            set -g fish_color_quote                 af3a03
            ### Will be removed in 3.2.0
            set -g fish_color_match                 bryellow --background=red
        case 'dark'
            ## red
            set -g fish_color_error                 cc241d
            ## blue
            set -g fish_color_param                 83a598
            set -g fish_color_cwd                   83a598
            ## green
            set -g fish_color_command               b8bb26
            set -g fish_color_user                  b8bb26
            ## yellow
            set -g fish_color_search_match          bryellow --background=brblack
            set -g fish_color_history_current       yellow --bold
            ## purple
            set -g fish_color_operator              d3869b
            set -g fish_color_escape                d3869b
            set -g fish_color_cwd_root              d3869b
            ## aqua
            set -g fish_color_end                   8ec07c
            set -g fish_color_redirection           8ec07c
            ## fg
            set -g fish_color_normal                ebdbb2
            set -g fish_color_host                  ebdbb2
            set -g fish_pager_color_completion      ebdbb2
            set -g fish_color_comment               928374
            set -g fish_color_autosuggestion        928374
            set -g fish_color_valid_path            --underline
            set -g fish_pager_color_prefix          ebdbb2 --bold --underline
            set -g fish_color_selection             ebdbb2 --bold --background=928374
            set -g fish_pager_color_progress        ebdbb2 --bold --background=928374
            set -g fish_pager_color_description     B3A06D yellow
            set -g fish_color_cancel                -r
            ## orange
            set -g fish_color_quote                 fe8019
            ### Will be removed in 3.2.0
            set -g fish_color_match                 bryellow --background=red
    end
end
