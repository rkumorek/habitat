#!/usr/bin/env fish

if not set -q XDG_CONFIG_HOME
    echo XDG_CONFIG_HOME environment variable not set.
    return 1
end

set -l dir (dirname (status -f))

function link_config_dir --argument-names name
    if test ~/.config/$name
        read -l -P "Path ~/.config/$name already exists, delete? [y/n]? " confirmation 

        if test $confirmation = 'y'
            rm -rf ~/.config/$name
        else
            return
        end
    end

    ln -vs $dir/config/$name ~/$XDG_CONFIG_HOME
end

for filename in (basename ./config/*)
    link_config_dir $filename
end

ln -s $dir/home/.tmux.conf ~/.tmux.conf

