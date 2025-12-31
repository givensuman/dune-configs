# Copies the text in the command line to clipboard
function _fish_copyutils_copybuffer --description "Copy text in command line to clipboard"
    commandline | fish_clipboard_copy
    if command -v notify-send >/dev/null 2>&1
        notify-send "Copied to clipboard" --icon=dialog-information
    end
end
