<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_header.png" />

  <img src="https://img.shields.io/github/actions/workflow/status/givensuman/dune-os/build.yml?labelColor=purple" />
  <img src="https://img.shields.io/github/actions/workflow/status/givensuman/dune-os/build_iso.yml?label=build%20iso&labelColor=blue" />
  <img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/dune-os" />
</div>

## About

These are configuration files for my computer, intended for use with [Dune OS](https://github.com/givensuman/dune-os). Outside of what's listed in `brew_packages`, Fish is a requirement. Install it with:

```bash
rpm-ostree install --apply-live fish
sudo usermod -s $(which fish) $USER
```

If you plan on using these, remove `gh/` and `git/` as they'd be of no use to you but may cause issues if overriding files on your system.

<img src="https://github.com/givensuman/dune-os/blob/main/assets/screenshot.png" />

## Justfile

Use `just` to manage syncing these configurations as dotfiles.

|Script|Description|
|---|---|
| just sync-up-config \<config\> | Move a system config here |
| just sync-down-config \<config\> | Move a config here to the system |
| just sync-up-all | Run `just sync-up-config` for each config here |
| just sync-down-all | Run `just sync-down-config` for each config here |
| just sync-up-brew | Log installed packages to `brew_packages` |
| just sync-down-brew | Install packages logged in `brew_packages` |
| just sync-up | Run `just sync-up-all` and `just sync-up-brew` |
| just sync-down | Run `just sync-down-all` and `just sync-down-all` |


<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_footer.png" />
</div>
