#!/usr/bin/env fish

set -l dir (dirname (status -f))

function link_config_dir --argument-names name
    if test ~/.config/$name
        read -l -P "Path ~/.config/$name already exists, delete? [y/n]? " confirmation 

        if test $confirmation = 'y'
            rm -rf ~/.config/$name
        end
    end

    ln -vs $dir/config/$name ~/.config
end

for filename in (basename ./config/*)
    link_config_dir $filename
end

ln -s $dir/home/.tmux.conf ~/.tmux.conf

