# Run `just sync-up-all` and `just sync-up-brew`
sync-up: sync-up-all sync-up-brew
# Run `just sync-down-all` and `just sync-down-all`
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
  cp -r "$HOME/.config/{{ config }}" "$temp/"

  rm -rf "./{{ config }}" || true
  mv "$temp/{{ config }}" .
  rm -rf "$temp"

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
  cp -r "./{{ config }}" "$temp/"

  rm -rf "$HOME/.config/{{ config }}" || true
  mv "$temp/{{ config }}" "$HOME/.config/"
  rm -rf "$temp"

# Run `just sync-down-config` for each config here
sync-down-all:
  #!/bin/bash
  set -euxo pipefail
  for dir in */; do
    [[ ! -d "$dir" ]] && continue

    dirname=$(basename "$dir")
    just sync-down-config "$dirname"
  done

# Install packages logged in `brew_packages`
sync-up-brew:
  #!/bin/bash
  set -euxo pipefail
  brew leaves > brew_packages

# Install packages from log
sync-down-brew:
  #!/bin/bash
  set -euxo pipefail
  xargs brew install < brew_packages
