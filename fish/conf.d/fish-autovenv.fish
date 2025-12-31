# Automatically source and deactivate Python virtual environments
function _autovenv --on-variable PWD
    if type -q $autovenv_disable
        return 0
    end

    set venv ./.venv

    if test -d $venv
        # if current directory has a ".venv" folder
        source $venv/bin/activate.fish

    else if type -q deactivate
        # otherwise, we may have just left one
        deactivate
    end
end

function _fish_autovenv_install --on-event fish-autovenv_install
end

function _fish_autovenv_uninstall --on-event fish-autovenv_uninstall
    functions --erase _autovenv

    set --erase autovenv_disable
end

function _fish_autovenv_update --on-event fish-autovenv_update
  _fish_autovenv_uninstall
  _fish_autovenv_install
end
