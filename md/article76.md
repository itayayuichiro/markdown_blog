---
title: "Railsモデルが定義されているかどうかを確認する方法"
---

## 概要
これを実現する方法は、#missing_nameまたは#missing_name?を使用してNameErrorを捕捉することです

```
begin
  HelloWorld
rescue NameError => e
  e.missing_name
end
# => "HelloWorld"
```

詳細についてはドキュメントを参照してください。

これが醜いと感じる場合、次のようなメソッドにラップすることもできます：

```ruby
def check_defined(constant)
  begin
    Oject.const_get(constant)
  rescue NameError => e
    !e.missing_name?(constant)
  end
  
  true
end
```

この他にも、これがRailsの読み込みの問題によるものかどうかを確認する必要があります。