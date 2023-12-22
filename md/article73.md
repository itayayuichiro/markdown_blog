---
title: "Rails7.0.6で変更されたFix autosave associations with validations added on :base of the associated objectsについての解説"
---

## よく分かる解説

### 修正PR

[https://github.com/rails/rails/pull/48413/](https://github.com/rails/rails/pull/48413/files)

### 概要
- 7.0.5と7.0.6で:baseというところにエラーを入れた場合の挙動がことなる

## コードベースでの解説&実例

### 検証用コード
検証するコードはこちら

モデルを２つ用意する

```ruby
# User.rb
class User < ActiveRecord::Base
  has_many :posts, autosave: true, index_errors: true, anonymous_class: Post
end

# Post.rb
class Post < ActiveRecord::Base
  validate :should_be_not_null

  private
    def should_be_not_null
      errors.add(:base, "should be not null") if user_id.nil?
      errors.add(:test, "should be not null") if user_id.nil?
    end
end
```

その上で下記の処理を実行する

```ruby
user = User.new
post = Post.new
user.posts = [post]
user.valid?
user.errors
```

### 結果
#### Rails7.0.5
```
=> #<ActiveModel::Errors [#<ActiveModel::NestedError attribute=posts[0].base, type=should be not null, options={}>, #<ActiveModel::NestedError attribute=posts[0].test, type=should be not null, options={}>]>
```

上記のようにbaseも他のキーと同じように.baseの中にエラーが有ることになる

#### Rails7.0.6
```
=> #<ActiveModel::Errors [#<ActiveModel::NestedError attribute=posts[0], type=should be not null, options={}>, #<ActiveModel::NestedError attribute=posts[0].test, type=should be not null, options={}>]>
```

上記のようにbaseは他のキーとは違い直接オブジェクトに紐づく形になる


### まとめ
リレーションしている「:base」にエラーを入れた際の挙動が異なる。

baseにエラーを入れてハンドリングしている場合関係がありそう。