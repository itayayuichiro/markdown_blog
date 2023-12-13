---
title: "rails7.0.6で変更されたFix EncryptedConfiguration not behaving like Hash [7-0-stable]についての解説"
---

## よく分かる解説

### 修正PR
https://github.com/rails/rails/pull/48557

### 前提
前提として「ActiveSupport::InheritableOptions.new」という機能がある。
これはハッシュをメソッドのように呼び出せるようにするものである。
例)
```ruby
hash = ActiveSupport::InheritableOptions.new({a: 1})
hash.a
```

### 今回との関係

これがEncryptedConfiguration でも使われていた。
ただ、これが処理の中で複数回呼ばれるような形になってしまっていた。
その結果値に対してkeysなどを使うと正しい値を返さないような状態になってしまっていた。

## コードベースでの解説&実例

### 検証用コード
試すコードは下記のもの

```ruby
@tmpdir = Dir.mktmpdir("config-")
@credentials_config_path = File.join(@tmpdir, "credentials.yml.enc")
@credentials_key_path = File.join(@tmpdir, "master.key")
File.write(@credentials_key_path, ActiveSupport::EncryptedConfiguration.generate_key)
@credentials = ActiveSupport::EncryptedConfiguration.new(
  config_path: @credentials_config_path, key_path: @credentials_key_path,
  env_key: "RAILS_MASTER_KEY", raise_if_missing_key: true
)
@credentials.write({ something: { good: true, bad: false, nested: { foo: "bar" } } }.to_yaml)

p @credentials.keys
```

### 結果
rails7.0.5では`[]`という空配列が返却され、rails7.0.6では`[:something]`といった形でちゃんとkeyが返ってくる


### まとめ
こちらの県は、ちゃんと情報が返ってこなかったものが返ってくるようになったという修正なので7.0.6にして際に不具合が起きるようになるということはなさそうです。
