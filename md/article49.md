---
title: Railsのルーティングでresoucesだけでなくresouceもとても便利だった話
---

## 概要

Railsでバックエンドの設計をしていて、resoucesではうまく表現できないルーティングがありそれが解決できたので共有

## 問題

設定画面があり、そこでは一覧表示、更新ができるようにするというものであった。
設定は下記のような感じでユーザーに対しては1対1のテーブルとなってます。

|name|type|
|-|-|
|id|int|
|user_id|int|
|setting1|boolean|
|setting2|boolean|

一覧と更新であればRailsのresoucesを使えばいいじゃないか！と思ったのですがそうすると
```rb
resources :settings, only: %i[index update]
```

|メソッド|パス|アクション|
|-|-|-|
|GET|/settings|settings#index|
|PATCH/PUT|/settings/:id|settings#update|

このように、patchの方がパスパラメータにIDを欲してくるんですね。
でも特にパスパラメータで渡すものがないので
```rb
resources :settings, only: %i[index]
patch setting_update, to: 'settings#update'
```
このような選択肢も考えたのですが...いけてないですね。

## 解決策

そこで単一リソースについてルーティングできないのかなと調べていたらあるじゃないですか！！
その名もresouce

この子を使うとさっきの問題が解決します。
```rb
resource :settings, only: %i[show update]
```

|メソッド|パス|アクション|
|-|-|-|
|GET|/settings|settings#show|
|PATCH/PUT|/settings|settings#update|

resourceはindexはないですが、他のアクションは全て持っているので汎用性も高いかなと思います！

参考文献
https://railsguides.jp/routing.html#%E5%8D%98%E6%95%B0%E5%BD%A2%E3%83%AA%E3%82%BD%E3%83%BC%E3%82%B9
