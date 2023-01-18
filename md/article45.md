---
title: Capistranoで開始、成功、失敗の通知をする方法
---

## 概要
Capistranoを使ってデプロイが成功したときに通知したい、失敗したときに通知したいといった要望がありまして、その方法を簡単にまとめました。

## 解決方法

早速方法ですが、下記のように書けば通知など送ることができます。
```
namespace :deploy do
  task :notice_start do
    # デプロイ開始時の処理を書く
  end
  task :notice_fail do
    # デプロイ失敗時の処理を書く
  end
  task :notice_success do
    # デプロイ成功時の処理を書く
  end
end
after 'deploy:started', 'deploy:notice_start'
after 'deploy:failed', 'deploy:notice_fail'
after 'deploy:finishing', 'deploy:notice_success'
```