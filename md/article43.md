---
title: export 'default' (imported as 'Router') was not found in 'vue-route vue2
---

## 概要
上記のエラーが出た際の対処法

## 解決方法

vue-routerのバージョンが悪さをしている場合がある。
最新のvue-routerだとだめな場合はバージョンを下げてインストールし直すとうまくいく。

```
npm uninstall vue-router
```

3.0を指定してインストールし直す

```
npm install vue-router@3.0
```

これで解消した。