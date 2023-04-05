---
title: "Rails5からRails6へのバージョンアップでエラーが発生！？ normalize_filter対応のカンタンな方法"
---

## 問題

Rails 5で自動生成されたルーティング周りの処理が、Rails 6にバージョンアップしたことにより動かなくなった。


```
NoMethodError: undefined method `[]' for nil:NilClass
/xxxx/.bundle/ruby/2.7.0/gems/actionpack-6.0.6.1/lib/action_dispatch/routing/inspector.rb:85:in `normalize_filter'
/xxxx/.bundle/ruby/2.7.0/gems/actionpack-6.0.6.1/lib/action_dispatch/routing/inspector.rb:65:in `format'
/xxxx/lib/tasks/routes_convert_vue.rake:35:in `block (2 levels) in <top (required)>'
/xxxx/.bundle/ruby/2.7.0/gems/sentry-ruby-5.4.2/lib/sentry/rake.rb:26:in `execute'
/xxxx/.bundle/ruby/2.7.0/gems/rake-12.3.3/exe/rake:27:in `<top (required)>'
```

## 解決方法

以下のようにコードを書き換える。

```
all_routes = Rails.application.routes.routes
inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
routes = inspector.format(Formatter.new, {})
```

変更前のコードは、normalize_filterメソッドの引数にENV['CONTROLLER']が渡されていた。しかし、Rails 6ではnormalize_filterメソッドの引数はハッシュ形式でなければならないため、空のハッシュ {} を引数に渡すように変更する必要がある。
