set -l brew_locations \
    /opt/homebrew/bin \
    /usr/local/bin \
    /usr/bin \
    /bin \
    /opt/homebrew/sbin \
    /usr/local/sbin \
    /usr/sbin \
    /sbin \
    "/home/linuxbrew/.linuxbrew/bin" \
    "/home/linuxbrew/.linuxbrew" \
    "~/.linuxbrew/bin" \
    "~/.linuxbrew/sbin"

if set -q brew_location
    fish_add_path $brew_location
else
    for brew_location in $brew_locations
        if contains $brew_location $PATH
            continue
        end

        if test -f $brew_location/brew
            fish_add_path $brew_location
            break
        end
    end
end

if not command -q brew
    echo "brew is not installed but you're"
    echo "sourcing the fish plugin for it"

    return 1
end

alias bleaves _fish_brew_bleaves

alias bl bleaves
alias bi 'brew install'
alias ba 'brew autoremove'
alias bcfg 'brew config'
alias bci 'brew info --cask'
alias bcin 'brew install --cask'
alias bcl 'brew list --cask'
alias bcn 'brew cleanup'
alias bco 'brew outdated --cask'
alias bcrin 'brew reinstall --cask'
alias bcubc 'brew upgrade --cask && brew cleanup'
alias bcubo 'brew update && brew outdated --cask'
alias bcup 'brew upgrade --cask'
alias bdr 'brew doctor'
alias bfu 'brew upgrade --formula'
alias bo 'brew outdated'
alias brewp 'brew pin'
alias brews 'brew list -1'
alias brewsp 'brew list --pinned'
alias bs 'brew search'
alias bsl 'brew services list'
alias bsoff 'brew services stop'
alias bsoffa 'bsoff --all'
alias bson 'brew services start'
alias bsona 'bson --all'
alias bsr 'brew services run'
alias bsra 'bsr --all'
alias bu 'brew update'
alias bubo 'brew update && brew outdated'
alias bubu 'bubo && bup'
alias bugbc 'brew upgrade --greedy && brew cleanup'
alias bup 'brew upgrade'
alias buz 'brew uninstall --zap'

eval (brew shellenv)

function _fish_brew_install --on-event fish-brew_install
    set -l brew_location (command -v brew | string replace -r '/bin/brew$' '')

    if not contains $brew_location $PATH
        fish_add_path $brew_location
    end
end

function _fish_brew_uninstall --on-event fish-brew_uninstall
    functions --erase bleaves

    functions --erase \
        bl \
        bi \
        br \
        bar \
        ba \
        bcfg \
        bci \
        bcin \
        bcl \
        bcn \
        bco \
        bcrin \
        bcubc \
        bcubo \
        bcup \
        bdr \
        bfu \
        bo \
        brewp \
        brews \
        brewsp \
        bs \
        bsl \
        bsoff \
        bsoffa \
        bson \
        bsona \
        bsr \
        bsra \
        bu \
        bubo \
        bubu \
        bugbc \
        bup \
        buz

    set --erase brew_location
    set --erase brew_locations
end

function _fish_brew_update --on-event fish-brew_update
    _fish_eza_uninstall
    _fish_eza_install
end
