# Homebrew Tap for Albedo

Homebrew tap providing the `albedo` formula.

## Install

```sh
brew tap klirix/tap
brew install albedo
```

To install the latest development version:

```sh
brew install --HEAD albedo
```

## Formula location

The formula is located at [Formula/albedo.rb](Formula/albedo.rb).

## Upgrading

```sh
brew update
brew upgrade albedo
```

## Maintaining the formula

### Stable releases

When a new release is tagged in the upstream `albedo` repository (for example, `v0.1.0`), update the formula to use the release tarball and its `sha256`.

### Bottles

Set up Homebrew’s `brew test-bot` workflow in this tap to build bottles (or run `brew test-bot` locally).

## Troubleshooting

```sh
brew doctor
brew reinstall albedo
```
