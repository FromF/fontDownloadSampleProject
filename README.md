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

## 参考にしたサイト

[Loading iOS fonts dynamically](https://marco.org/2012/12/21/ios-dynamic-font-loading)  
[Can I embed a custom font in a bundle and access it from an ios framework?](http://stackoverflow.com/q/14735522)  
[Xcode: Using custom fonts inside Dynamic framework](http://stackoverflow.com/q/30507905)  
[CGFontCreateWithDataProviderで固まるバグの対処方法（objective-c）](http://appstars.jp/archive/23)