SPDX Liteについては[SPDXの本家](https://spdx.github.io/spdx-spec/v2.3/SPDX-Lite/#g3-table-of-spdx-lite-fields)を参照してもらうのがあるべき姿だと思います。が、私が作業をするのに必要なので、ここでまとめます。

| # | 対応するSPDXの副節 | 項目名 | デフォルト値 | SPDXには必須か | 備考 |
|---- | :----: |------------------------- | :---: | ---  |--- |
|L1.1  |6.1  | SPDX Version              | SPDX-M.N | はい ||
|L1.2  |6.2  | Data License              | CC0-1.0 | はい ||
|L1.3  |6.3  | SPDX Identifier           | SPDXRef-DOCUMENT | はい ||
|L1.4  |6.4	 | Document Name	           | （なし） | はい ||
|L1.5  |6.5	 | SPDX Document Namespace | http://spdx.org/spdxdocs/[DocumentName]-[UUID] | はい ||
|L1.6  |6.8	 | Creator	                 | Person/Organization: "anonymous" / Tool: toolidentifier-version | はい ||
|L1.7  |6.9  | Created                   | （なし） | はい ||
|L2.1  |7.1	 | Package Name	             | （なし） | はい ||
|L2.2  |7.2	 | Package SPDX Identifier   | "SPDXRef-"[idstring] | はい ||
|L2.3  |7.3	 | Package Version           | （なし） | いいえ ||
|L2.4  |7.4	 | Package File Name         | （なし） | いいえ ||
|L2.4  |7.5	 | Package Supplier         | （なし） | いいえ |2.3で追加|
|L2.5  |7.7	 | Package Download Location | NONE/NOASSERTION | はい ||
|L2.6  |7.8	 | Files Analyzed            | true | いいえ ||
|L2.7  |7.11 | Package Home Page         | NONE/NOASSERTION | いいえ ||
|L2.8  |7.13 | Concluded License         | NONE/NOASSERTION | はい ||
|L2.9  |7.15 | Declared License          | NONE/NOASSERTION | はい ||
|L2.10 |7.16 | Comments on License       | （なし） | いいえ ||
|L2.11 |7.17 | Copyright Text            | NONE/NOASSERTION | はい ||
|L2.12 |7.20 | Package Comment           | （なし） | いいえ ||
|L2.12 |7.21 | External Reference field  | （なし） | いいえ |2.3で追加|
|L3.1  |10.1	 | License Identifier        | “LicenseRef-”[idstring] | （条件付き）はい ||
|L3.2  |10.2	 | Extracted Text            | （なし）  | （条件付き）はい ||
|L3.3  |10.3	 | License Name              | NOASSERTION | （条件付き）はい ||
|L3.4  |10.5	 | License Comment           |  （なし） | いいえ ||
