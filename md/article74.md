---
title: "Rails7.0.6で変更された[AR] Fix result with anonymous PG columns of different type from json についての解説"
---

## よく分かる解説

### 修正PR

[https://github.com/rails/rails/pull/45783](https://github.com/rails/rails/pull/45783)

### 概要
- 7.0.5と7.0.6でPostgreSQLの->と->>を両方使った際の挙動に変更が加わった模様

## コードベースでの解説&実例

### 検証用コード
検証するコードはこちら

PostgreSQLでテーブルを用意してデータを入れる

```ruby
ActiveRecord::Base.connection.create_table("json_data_type") do |t|
       t.public_send :json, "payload", default: {} # t.json 'payload', default: {}
       t.public_send :json, "settings"             # t.json 'settings'
       t.public_send :json, "objects", array: true # t.json 'objects', array: true
end


def insert_statement_per_database(values)
    "insert into json_data_type (payload) VALUES ('#{values}')"
end
ActiveRecord::Base.connection.execute(insert_statement_per_database('{"a":{},"b":"b"}'))
```

その上で下記の処理を実行する

```ruby
JsonDataType.class.pluck(Arel.sql("payload->'a', payload->>'b'"))
```

### 結果
#### Rails7.0.5
```
  JsonDataType Pluck (3.0ms)  SELECT payload->'a', payload->>'b' FROM "json_data_type"
=> [["{}", "b"]]
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
