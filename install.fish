#!/usr/bin/env fish

set dirname (cd (dirname (status -f)); and pwd) 

function link_config_dir --argument-names name
    if test ~/.config/$name
        read -l -P "Path ~/.config/$name already exists, delete? [y/n]? " confirmation 

        if test $confirmation = 'y'
            rm -rf ~/.config/$name
        end
    end

    ln -vs $dirname/config/$name ~/.config
end

for filename in (basename ./config/*)
    link_config_dir $filename
end

ln -s $dirname/home/.tmux.conf ~/.tmux.conf

