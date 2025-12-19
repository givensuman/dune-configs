function _fish_copyutils_install --on-event fish-copyutils_install
end

function _fish_copyutils_uninstall --on-event fish-copyutils_uninstall
    functions --erase _copybuffer
    functions --erase copyfile
    functions --erase copypath

    set --erase copybuffer_keybind
end

function _fish_copyutils_update --on-event fish-copyutils_update
    _fish_copyutils_uninstall
    _fish_copyutils_install
end
