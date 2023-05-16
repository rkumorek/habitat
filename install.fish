#!/usr/bin/env fish

if not set -q XDG_CONFIG_HOME
    echo XDG_CONFIG_HOME environment variable not set.
    return 1
end

set home $XDG_CONFIG_HOME
set dir (realpath (dirname (status -f)))

function link_config_dir --argument-names name
    set -l path "$home/$name"

    if test -e $path
        read -l -P "Path $path already exists, delete? [y/n]? " confirmation 

        if test $confirmation = 'y'
            rm -r $path
        else
            return
        end
    end

    ln -vs "$dir/config/$name" $home
end

for filename in (basename -a ./config/*)
    link_config_dir $filename
end

ln -s $dir/home/.tmux.conf ~/.tmux.conf

