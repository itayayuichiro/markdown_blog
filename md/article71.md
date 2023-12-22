---
title: "Rails7.0.5.1で変更された[CVE-2023-28362] Possible XSS via User Supplied Values to redirect_toについての解説"
---

## 対象
Railsのバージョンを**7.0.5**から**7.0.5.1**に変更する人

## 情報ソース
Rails Versions 7.0.5.1, 6.1.7.4 have been released!

https://rubyonrails.org/2023/6/26/Rails-Versions-7-0-5-1-6-1-7-4-have-been-released


## 変更点
- `redirect_to`による脆弱性の対応

## 詳細
`redirect_to`を使っている場合にクロスサイトスクリプティング（XSS）の攻撃が発生する可能性がある模様。

ただし、`redirect_to`を使っている場所全てで発生するということではなく、**外部のホストにリダイレクトを許可している場合**に発生しうるというものです。

外部ホストにリダイレクトを許可する設定は

```rb
redirect_to 'https://example.com', allow_other_host: true
```
こんな形でallow_other_hostをtrueに意図的にする必要があります。

逆に言えばこの設定を意図的にしなければRails側でエラーになるようになっています。

なので、これらを使っていない場合は特に影響はありません。

また使っていた場合もバージョンをあげることで解消されるので気付いた時にあげましょう。
