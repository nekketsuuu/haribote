# 熱血版 Haribote OS

『30日でできる！　OS自作入門』を読みながら書いたものを保存しておくリポジトリです。

## 実験環境

* Ubuntu 18.04 LTS Bionic
* QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.4)

フロッピーディスクは使わず、作ったイメージファイルを QEMU で実行しました。

## 事前準備

必須

```sh
sudo apt install build-essential qemu
```

オプショナル

```sh
sudo apt install ghex hexedit
```

バイナリエディタは GHex と hexedit を併用しています。hexedit は `hexedit -l16 <ファイル名>` のようにオプションを付けて起動すると横バイト数が書籍と同じになります。

## 実行方法

```sh
make
```

## リンク

* [「30日でできる！ OS自作入門」のサポートページ](http://hrb.osask.jp/) : 何回か URL が変わっています。また、内部のページもリンク切れが多いです。
