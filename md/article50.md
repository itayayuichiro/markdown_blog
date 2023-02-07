---
title: SlimからVueへの書き換える際のチートシート
---

RailsのViewで使っているSlimからVueにスムーズに書き換えるためのチートシート

## for文
```rb
elements.each do |element|
```
↓
```js
template(v-for="element in elements")
```

## if文
```rb
if xxx == false
```
↓
```js
template(v-if="xxx == false")
```

## 紐づく関連テーブル情報取得

```rb
elements.child_table.name.present?
```
↓
```rb
elements.to_json(include: :child_table)
```
or
```rb
elements.to_json(include: { child_table: {include: :grand_child_table}})
```
上記のように子供or孫のテーブル情報まで返すようにして
```js
elements.child_table.name
```
で参照

### 他の記事

- [Capistranoで開始、成功、失敗の通知をする方法 | 昼寝王子のエンジニアブログ](./article45.html)
- [How to notify start, success and failure in Capistrano | 昼寝王子のエンジニアブログ](./article46.html)
- [Rubyでフォーマットが決まっている文字列を日付に変換する | 昼寝王子のエンジニアブログ](./article47.html)
- [bashのif文で大小比較する時の注意点 そのようなファイルやディレクトリはありません | 昼寝王子のエンジニアブログ](./article48.html)
- [Railsのルーティングでresoucesだけでなくresouceもとても便利だった話 | 昼寝王子のエンジニアブログ](./article49.html)
