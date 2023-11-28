---
title: Ruby on Rails: ActiveRecordデータを効果的にHashに変換する方法
---

Ruby on Railsの開発で、ActiveRecordやクラスのデータをHashにする方法を紹介します。

## 1. attributesメソッド
基本的な使い方:

```ruby
user = User.first
user.attributes
```

- 特徴
  - ActiveRecordオブジェクトの属性をHashに変換する。

## 2. as_jsonメソッド
基本的な使い方:

```ruby
user = User.first
user.as_json

# 特定のキーのみ取得
user = User.first
user.as_json(only: :name)

```

- 特徴
  - JSON形式でHashに変換する。
  - 出力を変更することができる



## 3. to_hメソッド
基本的な使い方:

```ruby
friends_list = [[:alice, 8], [:bob, 9], [:charlie, 8]]
friends_hash = friends_list.to_h
# => {:alice=>8, :bob=>9, :charlie=>8}
```

- 特徴
  - **ActiveRecordオブジェクトは変換できない**
  - 配列をHashに変換する。




## まとめ
to_hはActiveRecordオブジェクトには使えないので、attributesメソッドかas_jsonメソッドを使うと良いでしょう。