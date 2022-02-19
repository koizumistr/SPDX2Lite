# SPDX2SPDXlite

名前の通り、SPDXからSPDX Liteに変換するプログラムです。
(SPDXやSPDX Liteについては説明不要でしょう、[ISO/IEC 5962:2021](https://www.iso.org/standard/81870.html)として国際標準にもなっているくらいですから。)
Rubyのスクリプトです。

## 使い方

~~~
SPDX2SPDXlite.rb [-x OUTPUTFILE] [-n PAD] YOURSPDXFILE
~~~

YOURSPDXFILEにはTag Value形式のSPDXファイルを指定してください。
オプションを何も指定しなければ、入力されたSPDXをTag Value形式のSPDX Liteに変換したものを標準出力に出力します。

### オプション

#### x
SPDX Liteをxlsx形式で出力します。

#### n
xlsx形式で出力するときに、空白セルを指定された文字列で埋めます。
何も指定しなければ"-"で埋めます。


## おまけ

SPDX LiteはSPDXの部分集合ですから、「正しいSPDX Lite」は「正しいSPDX」であるとも言えます。
ですので、(このプログラムを使って出力した)Tag Value形式のSPDX Liteをxlsx形式に変換するのにも使えます。
