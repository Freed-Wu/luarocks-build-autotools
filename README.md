# luarocks-build-autotools

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Freed-Wu/luarocks-build-autotools/main.svg)](https://results.pre-commit.ci/latest/github/Freed-Wu/luarocks-build-autotools/main)
[![github/workflow](https://github.com/Freed-Wu/luarocks-build-autotools/actions/workflows/main.yml/badge.svg)](https://github.com/Freed-Wu/luarocks-build-autotools/actions)

[![github/downloads](https://shields.io/github/downloads/Freed-Wu/luarocks-build-autotools/total)](https://github.com/Freed-Wu/luarocks-build-autotools/releases)
[![github/downloads/latest](https://shields.io/github/downloads/Freed-Wu/luarocks-build-autotools/latest/total)](https://github.com/Freed-Wu/luarocks-build-autotools/releases/latest)
[![github/issues](https://shields.io/github/issues/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/discussions)
[![github/milestones](https://shields.io/github/milestones/all/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/milestones)
[![github/forks](https://shields.io/github/forks/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/network/members)
[![github/stars](https://shields.io/github/stars/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/stargazers)
[![github/watchers](https://shields.io/github/watchers/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/watchers)
[![github/contributors](https://shields.io/github/contributors/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/commits)
[![github/release-date](https://shields.io/github/release-date/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/releases/latest)

[![github/license](https://shields.io/github/license/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools)
[![github/languages/top](https://shields.io/github/languages/top/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools)
[![github/directory-file-count](https://shields.io/github/directory-file-count/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools)
[![github/code-size](https://shields.io/github/languages/code-size/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools)
[![github/repo-size](https://shields.io/github/repo-size/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools)
[![github/v](https://shields.io/github/v/release/Freed-Wu/luarocks-build-autotools)](https://github.com/Freed-Wu/luarocks-build-autotools)

[![luarocks](https://img.shields.io/luarocks/v/Freed-Wu/luarocks-build-autotools)](https://luarocks.org/modules/Freed-Wu/luarocks-build-autotools)

A luarocks build module based on autotools.

## Usage

`rockspec`:

```lua
-- ...
build = {
    type = "autotools",
    -- ...
}
```

It will do:

- call `autoreconf -vif` when `configure` doesn't exist
- call `./configure` with correct `prefix`, `libdir`, `datadir`
- `make clean`
- `make`
- copy dynamic libraries in `.libs` and `_libs` to luarocks lib directory
- copy lua files to luarocks lua directory
