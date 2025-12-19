# Copies the text in the command line to clipboard
# Binds function to `ctrl+o` or copybuffer_keybind environment variable
function _copybuffer --description "Copy text in command line to clipboard"
    commandline | fish_clipboard_copy
end

if set -q copybuffer_keybind
    # Bind `copybuffer` to copybuffer_keybind environment variable
    bind $copybuffer_keybind _copybuffer
else
    # or `ctrl+o` if one isn't set
    bind \co _copybuffer
end
