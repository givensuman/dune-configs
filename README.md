<div align="center">
  <img src="https://github.com/givensuman/goose-linux/blob/main/assets/goose.png" />
</div>

## About

These are configuration files for my computer, intended for use with [goose linux](https://github.com/givensuman/goose-linux).

If you plan on using these, remove `gh/` and `git/` as they'd be of no use to you but may cause issues if overriding files on your system.

<img width="2256" height="1504" alt="Screenshot_2026-01-07_23-02-43" src="https://github.com/user-attachments/assets/9e2f58c4-4d65-43fd-bcc7-0771c072872e" />

<img width="2256" height="1504" alt="Screenshot_2026-01-07_23-03-01" src="https://github.com/user-attachments/assets/7c83adb5-6497-4aea-a1e9-b6ee8675e237" />


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
  <img src="https://github.com/givensuman/goose-linux/blob/main/assets/banner.png" />
</div>
