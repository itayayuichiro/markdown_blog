---
title: Rubyでフォーマットが決まっている文字列を日付に変換する
---

## 概要
20230118.08.00.00といった文字列を受け取ったときにこれを
2023年1月18日 8時と解釈する方法を記載

## やり方
Datetimeクラスのstrptimeメソッドを使う。
```
DateTime.strptime('20230118.08.00.00', '%Y%m%d.%H.%M')
```

