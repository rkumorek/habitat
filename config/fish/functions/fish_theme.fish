function fish_theme -a action
    switch $action
        case 'init'
            # Return early if init was already called.
            if set -q __fish_color_theme_is_dark
                echo "Theme already initialised, use "fish_theme toggle" to change it."
                return 0
            end

            # Set color theme for top level shell based on current time.
            if test $SHLVL -eq 1
                set -l hour (date +"%H" | string replace -r "^0" "")
                set -l mode light

                if test $hour -ge 20 -o $hour -le 7
                    set mode dark
                end

                __fish_color_theme_set_variables $mode
                __fish_color_theme_set_fish_colors $mode
                theme_gruvbox $mode medium
                return 0
            end

            # Set color theme to match the theme of parent shell.
            switch $BAT_THEME
                case 'gruvbox-light'
                    __fish_color_theme_set_variables light
                    __fish_color_theme_set_fish_colors light
                case '*'
                    __fish_color_theme_set_variables dark
                    __fish_color_theme_set_fish_colors dark
            end
        case 'toggle'
            if test $__fish_color_theme_is_dark -eq 1
                theme_gruvbox light medium
                __fish_color_theme_set_fish_colors light
                __fish_color_theme_set_variables light
            else
                theme_gruvbox dark medium
                __fish_color_theme_set_fish_colors dark
                __fish_color_theme_set_variables dark
            end
    end
end

function __fish_color_theme_set_variables -a mode
    # Set variables for programs that support themes.
    set -gx BAT_THEME gruvbox-$mode

    # Set global variable to indicate colors were set.
    if test $mode = 'dark'
        set -g __fish_color_theme_is_dark 1
    else
        set -g __fish_color_theme_is_dark 0
    end
end

function __fish_color_theme_set_fish_colors -a mode
    set -l gray         928374
    # Initialise color variables for light theme
    set -l bg1          ebdbb2
    set -l fg0          282828
    set -l fg1          3c3836
    set -l fg2          504945
    set -l fg3          665c54
    set -l fg4          7c6f64
    set -l red          9d0006
    set -l green        79740e
    set -l yellow       b57614
    set -l blue         076678
    set -l purple       8f3f71
    set -l aqua         427b58
    set -l orange       af3a03

    if test $mode = 'dark'
        set bg1         282828
        set fg0         fbf1c7
        set fg1         ebdbb2
        set fg2         d5c4a1
        set fg3         bdae93
        set fg4         a89984
        set red         fb4934
        set green       b8bb26
        set yellow      fabd2f
        set blue        83a598
        set purple      d3869b
        set aqua        8ec07c
        set orange      fe8019
    end

    set -g fish_color_normal                $fg1
    set -g fish_color_command               $green
    set -g fish_color_keyword               $blue
    set -g fish_color_quote                 $orange
    set -g fish_color_redirection           $purple
    set -g fish_color_end                   $blue
    set -g fish_color_error                 $red
    set -g fish_color_param                 $fg2
    set -g fish_color_valid_path            --underline
    set -g fish_color_option                $aqua
    set -g fish_color_comment               $gray --italics
    set -g fish_color_selection             $bg1 --bold --background=$fg1
    set -g fish_color_operator              $purple
    set -g fish_color_escape                $purple
    set -g fish_color_autosuggestion        $fg3
    set -g fish_color_cwd                   $fg1
    set -g fish_color_cwd_root              $fg1
    set -g fish_color_user                  $fg1
    set -g fish_color_host                  $fg1
    set -g fish_color_host_remote           $fg1
    set -g fish_color_status                $fg1
    set -g fish_color_cancel                -r

    set -g fish_pager_color_progress        -r
    set -g fish_pager_color_prefix          $aqua
    set -g fish_pager_color_completion      $fg1 --underline
    set -g fish_pager_color_description     $fg1
end
