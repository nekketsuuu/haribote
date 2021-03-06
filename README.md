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

* テキストエディタ (Emacs, Vim, VSCode 等、何でも良い。)
* バイナリエディタ (参照: 下に書いてある開発メモ 1 日目)

## 実行方法

```sh
git clone --recurse-submodules https://github.com/nekketsuuu/haribote.git
cd haribote
make run
```

## 開発メモ

* 書籍正誤表のアーカイブは[こちら](https://web.archive.org/web/*/http://hrb.osask.jp:80/bugfix.html)。
* 1日目: バイナリエディタが必要となります。「Ubuntu binary editor」で調べると無数に出てくるので、好きなものを使います。僕は GHex と hexedit を気分に合わせて併用していました。
    * GHex: GUI エディタです。`sudo apt install ghex` でインストールできます。
    * hexedit: CLI エディタです。`sudo apt install hexedit` でインストールできます。`hexedit -l16 <ファイル名>` のようにオプションを付けて起動すると横バイト数が書籍と同じになります。`alias hexedit='hexedit -l16'` が便利です。
* 1日目: アセンブラが必要になります。今回は折角なので筆者が作った nask をビルドして使いましたが、nask の元となっている nasm を使うことでも開発できるようです。
    * [http://hrb.osask.jp/wiki/?tools/nask](https://web.archive.org/web/20160608145514/http://hrb.osask.jp/wiki/?tools/nask)
    * nasm を使う場合、サポートページに書いてあるように軽微な修正が必要です。
* 1日目: `imgtol.com` というのはドライブに刺さっているフロッピーへ img ファイルの内容を書き込むコマンドなので、今回は必要ありません。
* 2日目: メモリマップのページへのアーカイブは[こちら](https://web.archive.org/web/20070105015242/http://community.osdev.info/?(AT)memorymap)。osdev.org の[ここ](https://wiki.osdev.org/Memory_Map_%28x86%29)でもよい。
* 3日目: `edimg` における `copy` コマンドで `to:@:` と書くと「ディスクイメージ中の、`from` と同じファイル名へコピー」という意味になります。これは `edimg` がこの書き方を特別扱いしているからです。詳しいことは書籍についてきたデータの `omake/tolsrc/edimg0j/document.txt` に書いてあります。
* 3日目: 筆者が改造した `cc1` (Hikalium さんのリポジトリでは `gocc1` となっているもの) で `.c` から `.gas` を作るのと、GCC 7 で `-S` オプションを使って `.gas` を作るのとでは、生成物に差があります。私の環境では後者を `gas2nas` するとエラーでした。面倒事を減らすには `gocc1` を使う方が良さそうです。
* 4日目: `gas2nas` が `nop` を解釈してくれないことに気づきました。`-Os` オプションをつけないと `gocc1` が `nop` を出力し、これがひっかかるようです。
* 7日目: 僕の環境ではバッファ作らなくても Ctrl の押し離しをちゃんと処理できていました。
* 8日目: 2 バイトずつ送られてくるキーボード情報にせよ 3 バイトずつ送られてくるマウス情報にせよ、バッファが溢れちゃうとバイトがずれるのでバグる。バッファの幅は経験則で決めるしかないのだろうか？　→　8日目の harib05b ですぐ説明があった。そもそもバッファ幅に関係なくハードウェア不調でバイトがずれるかもしれない。1 バイト目でバリデーションができるので、不正なバイトだったら読み飛ばすようにすれば問題ない。なるほど。
* 8日目: 僕の環境はノートパソコンで、トラックパッドを使っています。この環境だと、一本指で左をクリックしても右をクリックしても L が反応して、二本指でクリックすると R が反応するようでした。何かしら設定が違うのかな。
* 9日目: メモリ容量を調べるのに最初から最後まで舐めているが、メモリ容量がギガバイト単位だとこれに時間がかかったりしないのだろうか。1 バイトごとにチェックしているので 3 GB だと 3 * 10^6 回くらいループする。時間にすると 0.1 秒未満くらい？　問題なさそう。
* 9日目: 筆者のプログラムでは結構な頻度で goto が出てくる。正直不必要に多いと思っていて、削減して良いと思うのだが、OS のプログラムだとこんなに goto するのは普通なのだろうか？

## リンク集

* [「30 日でできる！ OS 自作入門」のサポートページ](http://hrb.osask.jp/) : 何回か URL が変わっています。また、内部のページもリンク切れが多いです。**Internet Archive に結構残っています。**
* https://github.com/HariboteOS : hikalium さんが、30 日 OS 用のツール群を Windows 以外でもビルドできるようにしてくださっていました。
    * [こちらのブログ記事](https://hikalium.com/page/note/20161202.md)に書かれているように、tolsrc を Ubuntu 上でビルドするのは面倒です。たとえば go_0023s の `golib00.exe` が受け入れる .o ファイルは COFF 限定 (ELF では駄目) なので、Wine + MinGW でクロスコンパイルするなり `ar` を使うなりして対応しなければいけません。更にそれを乗り越えても今度は `__builtin_stdarg_start` がリンクできない問題にぶつかります……。
