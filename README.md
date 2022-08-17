#  TBX Scope

![Main window](https://raw.githubusercontent.com/buresdv/TBX-Scope/main/Images/Main%20Window.png)

## The Lightweight TBX Reader
TBX Scope is a lightweight browser for the Termbase Exchange Format (TBX). It's written mostly in SwiftUI with a few sprinkles of Cocoa.

## Cool Benchmarks
TBX Scope can load the entire Microsoft Terminology collection (around 33,000 individual entries) within a second and display them all without breaking a sweat.

## Why make this?
I often have to work with TBX files while doing translations. I got bored of opening them up in slow and clunky CAT software, so I made this utility to open and read them blazingly fast

## Roadmap
Here are the things that are implemented, and things that are still left to implement:
- [x] Parsing and showing basic source-target pairs
- [x] Nice performance
- [x] Correctly showing more than one target term per one source term
- [x] Showing some basic metadata
- [ ] Searching through the terms
- [ ] Showing more metadata
- [ ] Support for TBXs that have more than two languages
- [ ] Support for more tags (like *source*, *context* and *date*)
