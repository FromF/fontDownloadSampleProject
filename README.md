# TrueTypeフォントダウンロードして登録するサンプルコード

## はじめに

本コードは、Xcode8.3.3(Objective-C)にて独自フォントを外部サーバーなどからダウンロードして利用できるようにするためのサンプルプロジェクトです。

## 使うために

`ViewController.h`の下記define定義を書き換えてください。
PostScript名の確認方法は[こちらのサイト](http://develop.calmscape.net/dev/295/)など参照してください。  

```
//ダウンロードするフォントファイルが置いてあるURL
#define FONT_URL @"http://hogehoge.com/hoge.ttf"
//PostScriptのフォント名
#define FONT_POSTSCRIPT_NAME @"hoge"
```
