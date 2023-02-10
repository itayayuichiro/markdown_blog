---
title: 【2023年】世界一やさしいCypress環境構築手順
---

## 概要
Cypress初めて触ってみる人向けの資料

## 手順
### 準備
#### 作業用ディレクトリ作成し移動
```sh
mkdir cypress
cd cypress
```

#### Cypressのインストール
```sh
yarn add cypress
```
or
```sh
npm install cypress --save-dev
```
#### 初期設定＆起動
```sh
yarn run cypress open
```
or
```
npx cypress open
```
#### 初期起動画面
![スクリーンショット 2023-02-11 1.33.48.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/a8292931-125b-248e-069c-108ce6b7c56c.png)
「Continue」を選択

#### E2Eを選択

![スクリーンショット 2023-02-11 1.34.00.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/098bfbea-4055-57ca-1282-b77a0ffd5d3e.png)

#### ファイルの確認

![スクリーンショット 2023-02-11 1.34.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/e8c3e805-c7c8-bd55-c463-77d6f7f50377.png)

Continueを選択

#### Chromeを選択

![スクリーンショット 2023-02-11 1.34.18.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/7f813831-05ad-0df2-1360-bcd5dc6a29b3.png)

#### 空のspecを作成

![スクリーンショット 2023-02-11 1.41.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/bae6c9b9-c495-30b0-429f-0a926d519430.png)

![スクリーンショット 2023-02-11 1.41.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/8b6adf30-9c7c-7629-5b3f-1f1f3cd9681d.png)

![スクリーンショット 2023-02-11 1.41.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/a421fc90-45b2-a5d8-0a8d-9a9dea2110b1.png)



#### 勝手に実行される

![スクリーンショット 2023-02-11 1.42.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/83409/7d570dbd-562e-f628-1a49-8035d71df49b.png)

### コーディングに関して
#### コーディング方法
今まで画面上でぽちぽちしていたのですが、じゃあどうやって実際のテストとか書いてくねん？？って話なんですけど。
作成したディレクトリの中に`cypress/e2e/`というディレクトリがあり、そこを書き換えることで好きにコードが書けます。

#### ターミナルでの実行方法
下記のような形でファイルを指定することで実行できます。
ただ、GUIが充実しているのでそっちで実行の方がいい気がします。
コード編集したら自動でまた流れてくれますし。
```
yarn run cypress run --spec cypress/e2e/test.cy.js
```
or
```
npx cypress run --spec cypress/e2e/test.cy.js
```

#### 出力
ターミナル実行の場合ログの出力をしたくなるとおもうので紹介
cypress.config.jsを下記のように書き換え
```js
const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      on('task', {
        log(message) {
          console.log(message)
          return null
        },
      })
    },
  }
})
```

テストコードの中では
```
cy.task('log', '出力したいもの')
```
という形で出力できます。

### 実例紹介
あとはもう、実例みて行った方が早い気がするので色々載せます
#### Google 検索のコード
```js
describe('empty spec', () => {
  it('Googleで検索', () => {
    cy.visit('https://www.google.com/?hl=ja')
    cy.get('input').eq(0).type('綾瀬 居酒屋 食べログ{enter}')
    // 見出しを出力
    cy.get('h3').each(h3 => {
      cy.task('log', h3.text())
    })
  })
})
```
出力
```
綾瀬駅でおすすめの美味しい居酒屋をご紹介！ - 食べログ
綾瀬で人気の居酒屋 ランキングTOP20 - 食べログ
綾瀬でおすすめの美味しい居酒屋をご紹介！ - 食べログ
足立区綾瀬でおすすめの美味しい居酒屋をご紹介！ - 食べログ
千住・綾瀬・葛飾で人気の居酒屋 ランキングTOP20 - 食べログ
綾瀬駅でおすすめのグルメ情報をご紹介！ | 食べログ
綾瀬駅でランチに使える居酒屋 ランキング | 食べログ
綾瀬市でおすすめの美味しい居酒屋をご紹介！ - 食べログ
【個室あり】綾瀬駅でおすすめの居酒屋をご紹介！ - 食べログ
綾瀬のグルメ・レストランガイド - 食べログ
```
#### Google検索結果のテスト
E2Eの記事なのにスクレイピングっぽいのだけでは怒られそうなので
```js
describe('empty spec', () => {
  it('Google検索で食べログのページが1件目に表示される', () => {
    cy.visit('https://www.google.com/?hl=ja')
    cy.get('input').eq(0).type('綾瀬 居酒屋 食べログ{enter}')
    cy.get('h3').eq(0).should('have.text', '綾瀬駅でおすすめの美味しい居酒屋をご紹介！ - 食べログ')
  })
})
```
出力
```
    ✓ Google検索で食べログのページが1件目に表示される (5587ms)


  1 passing (7s)


  (Results)

  ┌────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ Tests:        1                                                                                │
  │ Passing:      1                                                                                │
  │ Failing:      0                                                                                │
  │ Pending:      0                                                                                │
  │ Skipped:      0                                                                                │
  │ Screenshots:  0                                                                                │
  │ Video:        true                                                                             │
  │ Duration:     6 seconds                                                                        │
  │ Spec Ran:     google-search-test.cy.js                                                         │
  └────────────────────────────────────────────────────────────────────────────────────────────────┘
```

以上

### 他の記事
- [docker-composeのvoluemsとcopyの話(超初心者) | 昼寝王子のエンジニアブログ](./article12.html)
- [Gtk: cannot open display: から抜け出した話(Docker + Alpine + Headless Chrome) | 昼寝王子のエンジニアブログ](./article13.html)
- [「エンジニアになりたいけどどうすればいいですか？」という質問について | 昼寝王子のエンジニアブログ](./article14.html)
- [Ruby + AWS Lambdaを使ってみて思った注意点 | 昼寝王子のエンジニアブログ](./article15.html)
- [「会話が続かないんですけど、どうすればいいですか...？？」という質問について | 昼寝王子のエンジニアブログ](./article16.html)
- [Web系の新人として僕が大切だと思うこと | 昼寝王子のエンジニアブログ](./article17.html)
- [qiitaのトレンドをスクレイピングするコードを作成 | 昼寝王子のエンジニアブログ](./article18.html)
- [Mac + DockerでCentOSを立ち上げたらyumが全く使えなかった話 | 昼寝王子のエンジニアブログ](./article19.html)
- [MacでError: Cannot find module './build/Release/diskusage.node'で躓いた話 | 昼寝王子のエンジニアブログ](./article20.html)
