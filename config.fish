if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path /usr/local/bin
fish_add_path $HOME/.cargo/bin

function __fish_rust_prompt
    set return_path (realpath (pwd))
    while true
        set cargo_toml (find . -maxdepth 1 -name "Cargo.toml" -type f | head -n 1)
        if test -n "$cargo_toml" 
            begin
                set cargo_version (cargo --version | awk '{print $2;}')
                echo -n (set_color yellow;) "󱘗 $cargo_version"
            end
            break
        end
        if test (realpath (pwd)) = (realpath $HOME)
            break
        end
        cd ../
    end
    cd $return_path
end

function __fish_node_prompt
    set return_path (realpath (pwd))
    while true
        set pj (find . -maxdepth 1 -name "package.json" -type f | head -n 1)
        if test -n "$pj" 
            begin
                set node_version (node --version)
                echo -n (set_color cyan;) " $node_version"
            end
            break
        end
        if test (realpath (pwd)) = (realpath $HOME)
            break
        end
        cd ../
    end
    cd $return_path
end

function __fish_git_prompt
    if test -n (echo -n (fish_git_prompt))
        set_color green 
        echo -n "󰐅" (fish_git_prompt) ""
    end
end

function fish_prompt
    set cur (echo -n (basename (pwd)) "")
    set -g __fish_git_prompt_showupstream verbose
    echo -n (set_color blue) " " (set_color red) (echo $cur) (__fish_git_prompt) (__fish_rust_prompt) (__fish_node_prompt) (set_color magenta) (set_color normal)
end
