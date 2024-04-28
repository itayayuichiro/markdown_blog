---
title: 「bin/rails server」は、ローカルサーバーを起動するはずのところ、テキストファイルを開いてしまう
---

## 概要

Railsのチュートリアルを始めたんだけど、このページに書いてある手順に従ったの。
でも、bin/rails serverというコマンドを実行すると、サーバーが起動するはずなのに、下に書かれているテキストファイルが開いちゃうんだ。
どうすればこのコマンドでサーバーを起動できる？
```
    #!/usr/bin/env ruby.exe
    APP_PATH = File.expand_path("../config/application", __dir__)
    require_relative "../config/boot"
    require "rails/commands"
```

## 対応法
Railsのサーバーを実行する方法として、"rails server" または "rails s" を使ってみてください。これはRailsサーバーを実行するよりも、より一般的な方法です。
