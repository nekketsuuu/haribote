# 熱血版 Haribote OS

『30日でできる！　OS自作入門』を読みながら書いたものを保存しておくリポジトリです。

## 実験環境

* Ubuntu 18.04 LTS Bionic (64bit)
* QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.4)

フロッピーディスクは使わず、作ったイメージファイルを QEMU で実行しました。

## 事前準備

### 必須 (ビルド・実行に必要)

* Make
* QEMU
* libc6-dev-i386

とりあえずインストールするだけなら、以下のようにすれば良いです。

```sh
sudo apt install build-essential libc6-dev-i386 qemu
```

### オプショナル (開発に必要)

* バイナリエディタ

## 実行方法

```sh
git clone --recurse-submodules https://github.com/nekketsuuu/haribote.git
cd haribote
make run
```

## 開発メモ

* 1日目: バイナリエディタが必要となります。「Ubuntu binary editor」で調べると無数に出てくるので、好きなものを使います。僕は GHex と hexedit を気分に合わせて併用していました。
    * GHex: GUI エディタです。`sudo apt install ghex` でインストールできます。
    * hexedit: CLI エディタです。`sudo apt install hexedit` でインストールできます。`hexedit -l16 <ファイル名>` のようにオプションを付けて起動すると横バイト数が書籍と同じになります。`alias hexedit='hexedit -l16'` が便利です。
* 1日目: アセンブラが必要になります。今回は折角なので筆者が作った nask をビルドして使いましたが、nask の元となっている nasm を使うことでも開発できるようです。
    * [http://hrb.osask.jp/wiki/?tools/nask](https://web.archive.org/web/20160608145514/http://hrb.osask.jp/wiki/?tools/nask)
    * nasm を使う場合、サポートページに書いてあるように軽微な修正が必要です。

## リンク集

* [「30 日でできる！ OS 自作入門」のサポートページ](http://hrb.osask.jp/) : 何回か URL が変わっています。また、内部のページもリンク切れが多いです。**Internet Archive に結構残っています。**
* https://github.com/HariboteOS : hikalium さんが、30 日 OS 用のツール群を Windows 以外でもビルドできるようにしてくださっていました。
    * [こちらのブログ記事](https://hikalium.com/page/note/20161202.md)に書かれているように、tolsrc を Ubuntu 上でビルドするのは面倒です。たとえば go_0023s の `golib00.exe` が受け入れる .o ファイルは COFF 限定 (ELF では駄目) なので、Wine + MinGW でクロスコンパイルするなり `ar` を使うなりして対応しなければいけません。更にそれを乗り越えても今度は `__builtin_stdarg_start` がリンクできない問題にぶつかります……。
