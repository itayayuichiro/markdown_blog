---
title: "rails7.0.6で変更されたFix defect in Enumerable#many introduced in rails/rails@d862dffについての解説"
---

## よく分かる解説

### 修正PR
https://github.com/rails/rails/pull/48412

### 前提
- many?という関数は複数あるかを真偽値で返すメソッドである。
- 例えば
  - `[1,2].many?`は`true`
  - `[1].many?`は`false`
- many?は下記のようにブロックを受け取ることもできる

```ruby
[1,2].many? do |a|
  a > 1
end
# => false
[2,3].many? do |a|
  a > 1
end
# => true
```
ブロック配下の条件にマッチするものが複数個あるかをチェックできる。


### 今回との関係
- 今回はこのmany?のブロック側の挙動に不具合があったので変更された
- 具体的なシーンとしては配列の中に配列があった場合にの挙動がおかしかったので修正された

## コードベースでの解説&実例

### 検証用コード
検証するコードはこちら
```ruby
[[1,2],[1,2]].many? do |a|
  a.sum == 3
end
```
コードとしては配列の中の配列の合計が3以上のものが複数あるかというのを検証するものだ。

### 結果
#### rails7.0.5
```
Traceback (most recent call last):
(irb):3:in `block in <main>': undefined method `sum' for 1:Integer (NoMethodError)
Did you mean?  succ
```

上記のようなエラーになる。

理由は修正のコメントにも記載があるが、ブロックの中での判定で配列が来ることが考慮されておらず、それによって不具合が起きているとのこと。

#### rails7.0.6
```
=> true
```
trueが返される


### まとめ
今まで不具合で動かなかったものが動くようになるということなので、バージョンを上げたことで不具合が起きたりすることはなさそう

