---
title: bashのif文で大小比較する時の注意点 ~そのようなファイルやディレクトリはありません~
---

## 概要
bashで下記のようなif文を書いて実行したら
```
if [ $# < 1 ] ; then
  echo "引数がありません"
  exit
fi
```
下記のようなエラーが表示されてしまったのでその解決策
```
そのようなファイルやディレクトリはありません
```

## 解決法

bashのif文で<>(大なり小なり)は使えないみたいでして

[シェルスクリプト（bash）のif文やwhile文で使う演算子について](https://qiita.com/egawa_kun/items/196cd354c0d8e4e0fefc#%E6%95%B0%E5%80%A4%E6%AF%94%E8%BC%83%E6%BC%94%E7%AE%97%E5%AD%90)

上記の記事を参考にして下記のように書き換えたら動きました！！
```
if [ $# -lt 1 ] ; then
  echo "引数がありません"
  exit
fi
```
