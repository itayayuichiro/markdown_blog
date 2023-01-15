---
title: Nokogiriで次の要素の情報を取得する方法
---

## 概要
Nokogiriでスクレイピングをする際に「次の要素」を取得する際の方法を記載。

## 解決方法

`next_element`を利用する。

例)
```
doc.css('div')[0].next_element
```

```
doc.css('div')map do |div|
    div.next_element
end
```

単体の要素にしか使えないので上記のように要素を確定させてその次を取得するようにすれば良い