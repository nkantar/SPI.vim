# SPI.vim

Sort Python `import`s by module/package name.

![SPI demo](https://cloud.githubusercontent.com/assets/568543/25214438/0043f7c4-254c-11e7-8444-be6a6fb78862.gif)

## What + Why

**SPI** provides an easy way to sort Python `import`s by module/package name.

Vim's built-in `:sort` is great for alphabetically sorting lines, but the inevitable combination of `import...` and `from...` means you're gonna' have a Bad Time&trade;.

[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/nkantar)

## Installation

### vim-plug

```viml
Plug 'nkantar/SPI.vim'
```

## Usage

```viml
" select some import lines
:SPI
```
