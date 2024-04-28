---
title: "IRBコンソールをリセットする方法"
---

## 概要

irbで起動したコンソールをリセットする方法

## 対応法
下記のように入力することでリセットすることができます
```
exec($0)
```

## 実行例
```
irb(main):001> a=1
=> 1
irb(main):002> a
=> 1
irb(main):003> exec($0)
irb(main):001> a
(irb):1:in `<main>': undefined local variable or method `a' for main:Object (NameError)
```
このようにaの定義がなくなっている