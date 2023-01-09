---
title: 【2022年】Vue2でvue-routerを使う際の注意点
---

## 概要
Vue2でvue-routerを使おうとした際に下記のようなエラーに遭遇したのでその共有
```
Uncaught TypeError: Cannot read properties of undefined (reading 'install')
```

## 事象の共有
Vue2のアプリケーションに
```
npm install vue-router
```
を実行してvue-routerを導入して起動したら発生した

また、アプリケーションを起動すると下記のような警告も出ていた

```
export 'default' (imported as 'Router') was not found in 'vue-router' (possible exports: NavigationFailureType, RouterLink, RouterView, START_LOCATION, createMemoryHistory, createRouter, createRouterMatcher, createWebHashHistory, createWebHistory, isNavigationFailure, loadRouteLocation, matchedRouteKey, onBeforeRouteLeave, onBeforeRouteUpdate, parseQuery, routeLocationKey, routerKey, routerViewLocationKey, stringifyQuery, useLink, useRoute, useRouter, viewDepthKey)
```

## 解決方法

vue-routerがうまく読み込めてないというより、読み込めているが書き方違うよって言われているように見える。
前にVue3を触っていたときにあるメソッドが存在していたので
一度vue-routerをアンインストールして

```
npm uninstall vue-router
```

3.0を指定してインストールし直す

```
npm install vue-router@3.0
```

これで解消した。