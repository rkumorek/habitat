function fish_terminal_theme -a theme
    if test $TERM = alacritty
        switch $theme
            case -l --list
                set -l list (string replace ".yml" "" (ls $XDG_CONFIG_HOME/alacritty/))
                for theme in $list
                    echo $theme
                end
            case '*'
                alacritty msg -s $ALACRITTY_SOCKET config "colors=$(cat $XDG_CONFIG_HOME/alacritty/$theme.yml)" -w $ALACRITTY_WINDOW_ID
        end
    end
end

# Set fish colors as universal variables.
function fish_theme_init_fish_colors
    set -U fish_color_normal                brwhite
    set -U fish_color_command               green --bold
    set -U fish_color_keyword               blue --bold
    set -U fish_color_quote                 yellow
    set -U fish_color_redirection           blue
    set -U fish_color_end                   blue
    set -U fish_color_error                 red
    set -U fish_color_param                 normal
    set -U fish_color_valid_path            --underline
    set -U fish_color_option                normal
    set -U fish_color_comment               white --italics
    set -U fish_color_selection             normal --background brblack
    set -U fish_color_operator              blue
    set -U fish_color_escape                magenta
    set -U fish_color_autosuggestion        white
    set -U fish_color_cwd                   normal
    set -U fish_color_cwd_root              normal
    set -U fish_color_user                  normal
    set -U fish_color_host                  normal
    set -U fish_color_host_remote           normal
    set -U fish_color_status                normal
    set -U fish_color_cancel                -r
    set -U fish_pager_color_progress        normal
    set -U fish_pager_color_prefix          --bold
    set -U fish_pager_color_completion      --underline
    set -U fish_pager_color_description     normal
end
