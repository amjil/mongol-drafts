# mongol_drafts

A Flutter app purpose-built for traditional Mongolian drafting. It delivers a consistent vertical writing experience on mobile while integrating tightly with custom menu bar and virtual keyboard components.

## Download

- **iOS**: Available on the [App Store](https://apps.apple.com/app/6756122733)
- **Android**: Download the latest APK from [GitHub Releases](https://github.com/amjil/mongol-drafts/releases/latest/download/app-release.apk)

## Feature Overview

- **Vertical Mongolian drafting** using the `mongol` package and `MongolTextField`, tuned for long-form layouts with generous line height, monospace feel, and live preview.
- **Offline draft library** backed by Drift to store drafts, tags, and search metadata, automatically creating a default workspace on first launch.
- **Virtual keyboard suite** integrating `mongol-virtual-keyboard` with single-row and stacked layouts, candidate panel, and system keyboard toggles for consistent typing.
- **Toolbar and tag bar** combining quick edit controls, global search, stacked keyboard switches, and inline tagging/filtering while writing.
- **Drawer navigation** exposing draft lists, search inputs, and nested filters; closing the drawer triggers state refresh so editor and list stay in sync.
- **Theme and environment controls** via `adaptive_theme`, `.env` runtime configs, and coordination with `mongol-menu-bar`, `mongol-virtual-keyboard`, and sibling repos.

Want to experiment with a block-style editor workflow? Check out the sibling project [`mgl-notes-app`](https://github.com/amjil/mgl-notes-app) for a more mature block editing experience.

## Getting Started

This repository targets Flutter 3.7.5 and `cljd`. If you are new to Flutter, start with:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For broader API references, platform notes, and tutorials, see the [official Flutter documentation](https://docs.flutter.dev/).

## Credits
This Mongolian Flutter App is made possible by the following projects:

- [suragch/mongol](https://github.com/suragch/mongol) - Mongolian vertical script widgets for Flutter apps 
- [suragch/mongol_code](https://github.com/suragch/mongol_code) - Unicode conversion library for traditional Mongolian script 

## Run Example
Use flutter version 3.7.5
1. Install the `clj` command.
2. Clone menu-bar repo `git clone https://github.com/amjil/mongol-menu-bar`.
3. Clone virtual keyboard repo `git clone https://github.com/amjil/mongol-virtual-keyboard`.
4. Clone drafts repo `git clone https://github.com/amjil/mongol-drafts`.
5. Enter the drafts folder `cd mongol-drafts`.
6. Init the example `clj -M:cljd init`.
7. Copy pubspec.yaml.bak to pubspec.yaml `cp pubspec.yaml.bak pubspec.yaml`.
8. Open a simulator `open -a Simulator`.
9. Run flutter `clj -M:cljd flutter`.

## License
Released under the MIT License. See `LICENSE` for the full text; 

built for Mongolian Users with ❤️.
