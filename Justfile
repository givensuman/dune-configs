# Run `just sync-up-all` and `just sync-up-brew`
sync-up: sync-up-all sync-up-brew

# Run `just sync-down-all` and `just sync-down-brew`
sync-down: sync-down-all sync-down-brew

# Move a system config here
sync-up-config config:
    #!/bin/bash
    set -euxo pipefail
    if [[ ! -d "$HOME/.config/{{ config }}" ]]; then
      echo "{{ config }} directory not found in ~/.config"
      exit 1
    fi

    echo "Syncing {{ config }}..."
    temp=$(mktemp -d)

    success=false
    trap "if [ '$success' = false ] && [ -d '$temp/backup' ]; then mv '$temp/backup' './{{ config }}' 2>/dev/null || true; rm -rf './{{ config }}/backup' || true; fi; rm -rf '$temp'" EXIT

     rsync -a "./{{ config }}/" "$temp/backup" 2>/dev/null || true
     rsync -a "$HOME/.config/{{ config }}/" "$temp/new"

     rm -rf "./{{ config }}" || true
     mv "$temp/new" "./{{ config }}"
     rm -rf "./{{ config }}/backup" || true
     success=true

# Run `just sync-up-config` for each config here
sync-up-all:
    #!/bin/bash
    set -euxo pipefail
    for dir in */; do
      [[ ! -d "$dir" ]] && continue

      dirname=$(basename "$dir")
      just sync-up-config "$dirname"
    done

# Move a config here to the system
sync-down-config config:
    #!/bin/bash
    set -euxo pipefail
    if [[ ! -d "./{{ config }}" ]]; then
      echo "{{ config }} doesn't appear to be tracked"
      exit 1
    fi

    echo "Syncing {{ config }}..."
    temp=$(mktemp -d)

    success=false
    trap "if [ '$success' = false ] && [ -d '$temp/backup' ]; then mv '$temp/backup' '$HOME/.config/{{ config }}' 2>/dev/null || true; rm -rf '$HOME/.config/{{ config }}/backup' || true; fi; rm -rf '$temp'" EXIT

     rsync -a "$HOME/.config/{{ config }}/" "$temp/backup" 2>/dev/null || true
     rsync -a "./{{ config }}/" "$temp/new"

     rm -rf "$HOME/.config/{{ config }}" || true
     mv "$temp/new" "$HOME/.config/{{ config }}"
     rm -rf "$HOME/.config/{{ config }}/backup" || true
     success=true

# Run `just sync-down-config` for each config here
sync-down-all:
    #!/bin/bash
    set -euxo pipefail
    for dir in */; do
      [[ ! -d "$dir" ]] && continue

      dirname=$(basename "$dir")
      just sync-down-config "$dirname"
    done

# Add config here to be tracked
add-config config:
    #!/bin/bash
    set -euxo pipefail
    if [[ -d "./{{ config }}" ]]; then
      echo "{{ config }} is already being tracked"
      exit 1
    fi

    if [[ ! -d "$HOME/.config/{{ config }}" ]]; then
      echo "{{ config }} doesn't appear to be on system"
      exit 1
    fi

     trap "rm -rf './{{ config }}'" ERR
     rsync -a "$HOME/.config/{{ config }}/" "./{{ config }}/"

# Remove a tracked config from here
remove-config config:
    #!/bin/bash
    set -euxo pipefail
    if [[ ! -d "./{{ config }}" ]]; then
      echo "{{ config }} isn't being tracked"
      exit 1
    fi

    rm -rf "./{{ config }}"

# Write log from brew packages
sync-up-brew:
    #!/bin/bash
    brew leaves > brew_packages

# Install brew packages from log
sync-down-brew:
    #!/bin/bash
    set -euxo pipefail
    [ ! -f brew_packages ] && exit 1
    xargs brew install < brew_packages

# Push changes to git
push:
    #!/bin/bash
    set -euxo pipefail
    git add .
    git commit -m "$(date +%Y%m%d-%H%M%S)"
    git push
