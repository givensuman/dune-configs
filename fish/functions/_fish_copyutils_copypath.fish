# Copies the path of given directory or file to the system
# Copies current dirrectory if not passed an argument
function _fish_copyutils_copypath --description "Copy path to clipboard"
    argparse --max-args 1 -- $argv
    or return

    switch "$argv"
        case ""
            # If no argument is passed, use current directory
            pwd | fish_clipboard_copy
        case \*
            # https://fishshell.com/docs/current/cmds/realpath.html
            realpath $argv[1] | fish_clipboard_copy
    end
end
