function fish_theme -a action
    switch $action
        case 'init'
            set -l mode dark

            if test "$BAT_THEME" = 'gruvbox-light'
                set mode light
            end

            __fish_color_theme_set $mode
        case 'light'
            __fish_color_theme_set light
        case 'dark'
            __fish_color_theme_set dark
    end
end

function __fish_color_theme_set -a mode
    set -gx BAT_THEME gruvbox-$mode

    if test $TERM = alacritty
        set -l dir (dirname (status -f))

        switch $mode
            case light dark
                set -l pattern '^colors: \\*(light|dark)'
                set -l command "s/$pattern/colors: *$mode/"
                sed -E -i '' $command "$dir/../../alacritty/alacritty.yml"

            case '*'
                echo "Provide mode (light or dark) argument."
                return 1
        end
    end

    set -g fish_color_normal                brwhite
    set -g fish_color_command               brgreen --bold
    set -g fish_color_keyword               brblue --bold
    set -g fish_color_quote                 yellow
    set -g fish_color_redirection           blue
    set -g fish_color_end                   blue
    set -g fish_color_error                 red
    set -g fish_color_param                 normal
    set -g fish_color_valid_path            --underline
    set -g fish_color_option                normal
    set -g fish_color_comment               white --italics
    set -g fish_color_selection             normal --background brblack
    set -g fish_color_operator              blue
    set -g fish_color_escape                magenta
    set -g fish_color_autosuggestion        white
    set -g fish_color_cwd                   normal
    set -g fish_color_cwd_root              normal
    set -g fish_color_user                  normal
    set -g fish_color_host                  normal
    set -g fish_color_host_remote           normal
    set -g fish_color_status                normal
    set -g fish_color_cancel                -r

    set -g fish_pager_color_progress        normal
    set -g fish_pager_color_prefix          normal --bold
    set -g fish_pager_color_completion      normal --underline
    set -g fish_pager_color_description     normal
end
