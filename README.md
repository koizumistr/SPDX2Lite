# SPDX2Lite（旧称 SPDX2SPDXlite）

旧称の通り、SPDXからSPDX Liteに変換するプログラムです。
（コマンドラインで入力時に楽したかったので名前を短く変更しました。）
(SPDXやSPDX Liteについては説明不要でしょう、[ISO/IEC 5962:2021](https://www.iso.org/standard/81870.html)として国際標準にもなっているくらいですから。)
Rubyのスクリプトです。

## 使い方

~~~
SPDX2Lite.rb [-x OUTPUTFILE] [-n PAD] YOURSPDXFILE
~~~

YOURSPDXFILEにはTag Value形式のSPDXファイルを指定してください。
オプションを何も指定しなければ、入力されたSPDXをTag Value形式のSPDX Liteに変換したものを標準出力に出力します。

### オプション

#### x
SPDX Liteをxlsx形式で出力します。

#### n
xlsx形式で出力するときに、空白セルを指定された文字列で埋めます。
何も指定しなければ"-"で埋めます。

## 注意
久々に動かしてみたらハマりました。内部で "require 'axlsx'" としているので、
~~~
gem install axlsx
~~~
としてから実行してみたのですが、Ruby 3.xではエラーになりました。Geminiに尋ねたら、そうではなく
~~~
gem install axlsx
~~~
とせよ、とのことです。理由が知りたい人はGeminiに聞いてください。

## おまけ
SPDX LiteはSPDXの部分集合ですから、「正しいSPDX Lite」は「正しいSPDX」であるとも言えます。
ですので、(このプログラムを使って出力した)Tag Value形式のSPDX Liteをxlsx形式に変換するのにも使えます。
