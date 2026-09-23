# Flare for Omarchy

> **This repo is only packaging.** The project itself lives at
> **[lunanoir21/flare-notch](https://github.com/lunanoir21/flare-notch)** —
> source, [changelog](https://github.com/lunanoir21/flare-notch/blob/main/CHANGELOG.md),
> docs, screenshots and the issue tracker are all there. Please open bugs and
> feature requests upstream; issues here are limited to the Omarchy wrapper
> itself (manifest, `Service.qml`, vendoring). If flare is useful to you, a
> ⭐ on [flare-notch](https://github.com/lunanoir21/flare-notch) is the best
> way to say so.

[Flare](https://github.com/lunanoir21/flare-notch) packaged as an Omarchy
shell plugin: an AI usage notch — Claude Code, Codex, OpenCode, Cursor,
Antigravity and Kiro limits, sessions and quotas in one edge-mounted notch,
with an hour-by-hour usage panel behind it.

This repo is a thin wrapper. All of flare's actual behavior lives in
[`flare-notch`](https://github.com/lunanoir21/flare-notch); the `flare/`
directory here is a vendored, pinned copy of its `ui/` (currently `1.0.0`),
and `Service.qml` is the one line Omarchy's plugin loader needs to start it.
Nothing is developed here — to follow the project, read the release notes,
or see what changed between vendored pins, go to the upstream repo.

`manifest.json` declares `kinds: ["service"]` with `keepLoaded: true` — the
same shape as Omarchy's own built-in `background`, `lock` and
`notifications` plugins. Flare owns its own per-screen `PanelWindow` and
layer-shell surface, so like those three it doesn't need omarchy-shell to
summon or position anything; it just needs to be instantiated once per
screen and stay loaded.

## Install

```bash
omarchy plugin add https://github.com/lunanoir21/flare-omarchy.git --enable
```

This installs the QML widget only. Flare also needs its own Rust binary —
Omarchy's plugin loader doesn't build it for you, so install it once,
separately, pinned to the exact commit this wrapper vendors from (not the
mutable default branch):

```bash
git clone https://github.com/lunanoir21/flare-notch
cd flare-notch
git checkout ae9ce9e87ce454300c0a95ce60047681ec3ae41a
./install.sh
```

`install.sh` builds `flare` with Rust 1.85+ if you have it, otherwise
downloads the prebuilt release and checks it against that release's
published `.sha256` before installing, and puts it on `~/.local/bin`. The
widget finds it there, on `PATH`, or wherever `flare.binary_path` points;
without it, the notch stays empty and `flare doctor` explains why.

To follow flare-notch's own tags instead of this fixed pin once you trust
the upstream release process, use `git checkout v1.0.0` (or any later
tag) in place of the commit above.

## Configure

Right-click the notch (or run
`omarchy-shell shell summon "io.github.lunanoir21.flare"` if you've wired up
a keybind) to open flare's own settings panel — providers, look, placement,
alerts and data. Settings are flare's own
(`~/.config/flare/config.toml`), independent of `~/.config/omarchy/shell.json`.

## Uninstall

```bash
omarchy plugin remove io.github.lunanoir21.flare
```

## Requirements

- Hyprland (the notch works on any wlr-layer-shell compositor; some session
  data is read from provider-specific locations regardless of compositor)
- Quickshell 0.3+ and Qt 6.6+
- The `flare` binary on `PATH`, in `~/.local/bin`, or named by
  `flare.binary_path` — see Install above
- At least one supported provider installed (Claude Code, Codex, OpenCode,
  Cursor, Antigravity or Kiro)

## Updating the vendored copy

`flare/` is a plain copy, not a git submodule — Omarchy's marketplace clones
a single ref of this repo, and a submodule would need an extra
`--recurse-submodules` step outside the plugin loader's control. To pick up
a new flare-notch release, copy its `ui/` over `flare/`, bump `version` in
`manifest.json`, and commit.

Watch the [upstream releases](https://github.com/lunanoir21/flare-notch/releases)
(or its changelog) to know when a new pin is worth taking.

## License

MIT, same as upstream — see [LICENSE](LICENSE).

---

<sub>Maintainer note — marketplace submission: category `Widgets`, tags
`Quickshell`, `Hyprland`, `AI`. `preview.png` is the project's front-page
cover image (1280×640).</sub>
