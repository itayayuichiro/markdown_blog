---
title: "Rails7.0.6で変更されたPreserve timestamp when setting an ActiveSupport::TimeWithZone value to timestamptz attribute についての解説"
---

## よく分かる解説

### 修正PR

[https://github.com/rails/rails/pull/48347](https://github.com/rails/rails/pull/48347)

### 概要
- 7.0.5と7.0.6でテーブルに入れたあとに取り出すとtimezone変わってしまうらしい

## コードベースでの解説&実例

### 検証用コード
検証するコードはこちら

PostgreSQLでテーブルを用意してデータを入れる

```ruby
ActiveRecord::Base.connection.create_table(:foos, force: true) do |t|
  t.datetime :happened_at
end
```

その上で下記の処理を実行する

```ruby
time = Time.now
time.zone = 'Pacific Time (US & Canada)'
p Foo.new(happened_at: time).happened_at.zone
p time.zone
```

### 結果
#### Rails7.0.5
```
"UTC"
"JST"
```

上記のように{}にダブルクオーテーションがついた形になる

#### Rails7.0.6
```
  JsonDataType Pluck (1.4ms)  SELECT payload->'a', payload->>'b' FROM "json_data_type"
=> [[{}, "b"]]
```

一方こちらでは上記のように{}にはダブルクオーテーションがつかない形になっている


### まとめ
PostgreSQLを使っていて->と->>を併用している部分がある場合は気にしたほうが良さそう。
