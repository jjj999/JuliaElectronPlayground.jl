# JuliaElectronPlayground

Julia と Electron を併用したデスクトップアプリケーションのためのテスト用アプリケーションです．

## Usage

```
$ julia

# In the REPL
julia> ]

pkg> activate .
pkg> resolve
pkg> [Ctrl-C]

julia> using JuliaElectronPlayground
julia> JuliaElectronPlayground.launch_gui()
```

## Package Structure

本パッケージはソースコードを大きく2つに分割しています．これらはそれぞれ Electron における `main` プロセスと `renderer` プロセスで動作するコードに相当し，前者は `src` ディレクトリ下に Julia によって，後者は `gui` ディレクトリ下に HTML，CSS，TS によって実装されています．後者についてはフレームワークとして [React](https://reactjs.org/) を使用しています．

## Motivation

Julia で記述した数値計算用コードを活用した GUI アプリケーションを作成する．

## アーキテクチャの問題点

### Electron の機能を 100 % 使用できない

Julia から Electron を呼び出す [Electron.jl](https://github.com/davidanthoff/Electron.jl) が Electron の機能を完全にカバーしていない．

### Typescript での IPC に難あり

Electron では `main` プロセスと `renderer` プロセス間で IPC を行っており，[Electron.jl](https://github.com/davidanthoff/Electron.jl) でも IPC はサポートされているが，Typescript に対するサポートがない．

## 代替アーキテクチャ

### Julia 側でサーバーを起動し，GUI アプリケーションと通信させながら処理を行う

このアーキテクチャは，Julia に直接 Electron のインターフェースを呼び出させるようなことはせず，計算エンジンを GUI アプリケーションから完全に独立した1つのアプリケーションとして起動し，所定のプロトコルに基づいて通信を行いながら処理を行うものである．このアーキテクチャでは，それぞれのアプリケーションは自身のドメインを維持しつつ処理を行えるので，開発自体は容易であるが，2つのアプリケーションで1つの目的を達成するので，配布方法については十分な検討が必要になる（GUI アプリケーションはインストールされているが，計算エンジンがインストールされていないという事態は避けなければならない）．
