function nvm_select
    set -l installed (string match -r "v\d+\.\d+\.\d+" (nvm list))
    set -l len (string length (string trim "$installed"))
    
    if test $len -eq 0
        echo 'No node versions found'
        return 1
    end

    echo 'Type one of the numbers listed below'
    set -l cnt 0
    for line in $installed
        echo "$cnt: $line"
        set cnt (math $cnt + 1)
    end

    set -l option $installed[(math (read) + 1)]

    switch $option
        case 'v*'
            if test $nvm_default_version != $option
                set -u nvm_default_version $option
            end

            echo "Default nvm version:" $nvm_default_version
        case '*'
            echo 'Invalid option' $option
            return 1
    end
end
