---
title: Rails + punditで既存のアクションの全て認可を全てdenyにする
---

## 概要
punditというと下記のように制御を行います。

posts_controller.rb
```rb
class PostsController < BaseController
  include Pundit

  def index
    authorize Post
  end
  def search
    authorize Post
  end
end
```

このようなコントローラーがあった場合に下記のようなベースのポリシーファイルポリシーファイルを作成することで制御をかけられます。
自動生成される
application_policy.rb
```rb
# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end

```

post_policy.rb
```rb
# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    true
  end
  def search?
    false
  end
end
```

このように定義することでindexにはアクセスでき、searchにはアクセスできないといった認可設定が可能になります。

## やりたいこと
ただ、この枠組みに囚われると既存のものに対して全部制御かけたければ
- 膨大な量のpolicyファイルを定義
- 全てのコントローラーにauthorizeを設置
上記をしなくてはなりません。これはやりたくない。

ポリシーを定義していない＝基本的にNGにしたい

ベースのコントローラーを用意して
```rb
class BaseController < ApplicationController
  include Pundit

  before_action :check_role

  def check_role
    # Adminアカウントの場合ロールチェックしない
    return if current_user.role_admin?

    begin
      authorize request.controller_class.controller_name.classify.constantize
    rescue Pundit::NotAuthorizedError, Pundit::NotDefinedError, NoMethodError
      # 権限エラー
    end
  end
end
```

このように定義をして他のコントローラーに継承させることで、定義がないものに関しても権限がなかった場合の処理と一緒にできる&全てのコントローラで自動でauthorizeを設置したことになる。

## 解説

何をしてるんだ？
```rb
authorize request.controller_class.controller_name.classify.constantize
```
ここは、リクエストされたコントローラーからポリシーを引っ張ってきています。
具体的にはリクエストされたコントローラーを前もって取ってきて、そこからクラス名を取得してクラスに変換して渡してます。

```rb
rescue Pundit::NotAuthorizedError, Pundit::NotDefinedError, NoMethodError
```
こちらは権限エラー処理になります。
1個目は、punditのもともともっている権限エラー
2個目は、punditでポリシーファイルが定義されていなかった場合のエラー
3個目は、punditでポリチーファイルが定義されていたが該当メソッドのポリシーが定義されていなかった場合のエラー


これで既存のプロジェクトにpundit入れたいという場合にも柔軟に対応できるかなと思いました。