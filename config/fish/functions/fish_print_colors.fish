function fish_print_colors -a which --description "Print terminal and fish colors"
    # https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/e50a28ec54188d2413518788de6c6367ffcea4f7/print256colours.sh
    function __contrast_color -a color
        if test 0 -lt $color -a $color -lt 16
            return 0
        else if test 0 -eq $color
            return 15
        else if test 231 -lt $color -a $color -lt 244
            return 15
        else if test 244 -lt $color
            return 0
        end

        # All other colours:
        # 6x6x6 colour cube = 16 + 36*R + 6*G + B  # Where RGB are [0..5]
        # See http://stackoverflow.com/a/27165165/5353461
        set -l r (math "($color-16) / 36")
        set -l g (math "(($color-16) % 36) / 6")
        set -l b (math "($color-16) % 6")

        # If luminance is bright, print number in black, white otherwise.
        # Green contributes 587/1000 to human perceived luminance - ITU R-REC-BT.601
        if test $g -gt 2
            return 0
        else
            return 15
        end

        # Uncomment the below for more precise luminance calculations

        # # Calculate percieved brightness
        # # See https://www.w3.org/TR/AERT#color-contrast
        # # and http://www.itu.int/rec/R-REC-BT.601
        # # Luminance is in range 0..5000 as each value is 0..5
        # set -l luminance (math "($r * 299) + ($g * 587) + ($b * 114)")

        # if test "$luminance > 2500"
        #     return 0
        # else
        #     return 15
        # end
    end

    function __print_color -a color
        __contrast_color $color
        set -l contrast $status

        printf "\e[48;5;%sm" "$color"                # Start block of colour
        printf "\e[38;5;%sm%3d" "$contrast" "$color" # In contrast, print number
        printf "\e[0m "                              # Reset colour
    end

    function __print_run -a from -a to
        for i in (seq $from $to)
            __print_color $i
        end
        printf "\n"
    end

    function __print_blocks -a rows -a blocks -a cols -a start
        set -l size (math "$rows * $cols")
        set -l r (math $rows - 1)
        set -l c (math $cols - 1)
        set -l b (math $blocks - 1)

        for row in (seq 0 $r)
            for block in (seq 0 $b)
                for col in (seq 0 $c)
                    set -l idx (math "$start + $row * $cols + ($size * $block) + $col")
                    __print_color $idx
                end
                printf "  "
            end
            printf "\n"
        end
    end

    if test -z $which
        __print_run 0 15
        printf "\n"
        __print_blocks 6 3 6 16
        printf "\n"
        __print_blocks 6 3 6 124
        printf "\n"
        __print_run 232 243
        __print_run 244 255
        return
    end

    # ----------

    function __print_fish_colors --description 'Shows the various fish colors being used'
        set -l clr_list (set -n | grep fish | grep color | grep -v __)
        if test -n "$clr_list"
            set -l bclr (set_color normal)
            set -l bold (set_color --bold)
            printf "\n| %-38s | %-38s |\n" Variable Definition
            echo '|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|'
            for var in $clr_list
                set -l def $$var
                set -l clr (set_color $def)
                or begin
                    printf "| %-38s | %s%-38s$bclr |\n" "$var" (set_color --bold white --background=red) "$def"
                    continue
                end
                printf "| $clr%-38s$bclr | $bold%-38s$bclr |\n" "$var" "$def"
            end
            echo '|________________________________________|________________________________________|'\n
        end
    end

    __print_fish_colors
end

