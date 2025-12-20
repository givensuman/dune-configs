<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_header.png" />
</div>

## About

These are configuration files for my computer, intended for use with [Dune OS](https://github.com/givensuman/dune-os).

If you plan on using these, remove `gh/` and `git/` as they'd be of no use to you but may cause issues if overriding files on your system.

<img src="https://github.com/givensuman/dune-os/blob/main/assets/screenshot.png" />

## Justfile

Use `just` to manage syncing these configurations as dotfiles.

|Script|Description|
|---|---|
| just add-config \<config\> | Add config here to be tracked |
| just remove-config \<config\> | Remove a tracked config from here |
| just sync-up-config \<config\> | Move a system config here |
| just sync-down-config \<config\> | Move a config here to the system |
| just sync-up-all | Run `just sync-up-config` for each config here |
| just sync-down-all | Run `just sync-down-config` for each config here |
| just sync-up-brew | Write log from brew packages |
| just sync-down-brew | Install brew packages from log |
| just sync-up | Run `just sync-up-all` and `just sync-up-brew` |
| just sync-down | Run `just sync-down-all` and `just-sync-down-brew` |
| just push | Push changes to git |


<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_footer.png" />
</div>
