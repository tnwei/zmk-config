# zmk-config

ZMK config for the [TOTEM](https://github.com/GEIGEIGEIST/TOTEM) 38-key split keyboard.

## Keymap philosophy

This keymap is me gradually learning how to use a 40% keyboard. The layout is based on my Sofle layout, which in turn was based on my Mistel Barocco layout back in the day.

## How this is set up

This repo is cobbled together from GEIGEIGEIST/zmk-config-totem (hardware definition) and rafiks/zmk-totem-module (ZMK Studio layout helpers). Was going to fork GEIGEIGEIST's repo but saw that it was marked as outdated, thus took a step back to build a new repo. rafiks repackaged the shield as a proper ZMK module, however I prefer being able to build this repo standalone and offline without linking it to another repo. Thus the TOTEM files are vendored in `boards/shields/totem`, following the same approach as the original author.

## What is where

- `config/totem.keymap`: The actual keymap file, edit this to modify the keyboard. To switch keymaps, rename the desired file to `totem.keymap`
- `config/totem.conf`: Kconfig (ZMK config system) overrides
- `boards/shields/totem/`: Vendored shield definition (from GEIGEIGEIST, 2022)
- `boards/shields/totem/totem_layout.dtsi`: ZMK Studio physical layout (key positions) from rafiks
- `boards/shields/totem/totem_layout.json`: QMK-format layout (for converter tools) from rafiks

## Building with gh actions

Update files in `config/`, then push to GitHub. Will build automatically!

## Building locally

Have a Makefile for this that runs `west build` from `zmk/app/` with:
- `-DSHIELD=totem_left|totem_right`
- `-DZMK_CONFIG` pointing to `config/`
- `-DZMK_EXTRA_MODULES` pointing to repo root (shield is vendored here)

### Setup (one-time)

`uv tool install west zmk`, then run `make setup` which clones ZMK into zmk-config/zmk/, inits west, and updates dependencies. Also need to have some compilers downloaded. Not too straightforward and I actually didnt follow through after seeing the gh action build.

### Build

```bash
make left       # left half
make right      # right half
make reset      # settings reset (unbrick keymap)
```

Firmware: `build/left/zephyr/zmk.uf2`, `build/right/zephyr/zmk.uf2`.

```bash
make clean      # wipe build/ and start fresh
```

## Flash firmware to keyboard

Double-tap reset on controller → USB storage appears → copy the `.uf2` file.

Note: make sure that the reset key (`&bootloader`) is actually in the keymap! 
If both halves lose bootloader access, flash `settings_reset` firmware as last resort. Wait but how??
