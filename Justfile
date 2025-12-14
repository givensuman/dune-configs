sync-up: sync-up-all sync-up-brew
sync-down: sync-down-all sync-down-brew

# Put local config here
sync-up-config config:
  #!/bin/bash
  set -euxo pipefail
  if [[ ! -d "~/.config/{{ config }}" ]]; then
    echo "{{ config }} directory not found in ~/.config"
    exit 1
  fi

  echo "Syncing {{ config }}..."
  rm -rf "./{{ config }}" || true
  cp -r "~/.config/{{ config }}" .

# sync-up for every tracked config
sync-up-all:
  #!/bin/bash
  set -euxo pipefail
  for dir in "./*/"; do
    [[ ! -d "$dir" ]] && continue

    dirname=$(basename "$dir")
    just sync-up-config "$dirname"
  done

# Put config onto system
sync-down-config config:
  #!/bin/bash
  set -euxo pipefail
  if [[ ! -d "./{{ config }}" ]]; then
    echo "{{ config }} doesn't appear to be tracked"
    exit 1
  fi

  echo "Syncing {{ config }}..."
  rm -rf "~/.config/{{ config }}" || true
  cp -r "./{{ config }}" "~/.config/{{ config }}"

# sync-down for every tracked config
sync-down-all:
  #!/bin/bash
  set -euxo pipefail
  for dir in "./*/"; do
    [[ ! -d "$dir" ]] && continue

    dirname=$(basename "$dir")
    just sync-down-config "$dirname"
  done

# Create log of installed packages
sync-up-brew:
  #!/bin/bash
  set -euxo pipefail
  brew leaves > brew_packages

# Install packages from log
sync-down-brew:
  #!/bin/bash
  set -euxo pipefail
  xargs brew install < brew_packages
