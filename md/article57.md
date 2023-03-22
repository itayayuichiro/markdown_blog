---
title: 【裏技】github actionでmarkdownファイルからhtmlファイルを自動生成する
---

## 概要

[pandoc](https://pandoc-doc-ja.readthedocs.io/ja/latest/users-guide.html)を用いることでmarkdown->htmlへの変換は可能だが毎回手作業でやるのが手間だったのでgithub actionでmarkdownファイルをpushしたら勝手にhtmlが生成されてpushされるように変更してみた。

## 手順

下記のような設定ファイルを作成します
.github/md-to-html.yml

```
on: push
jobs:
  build:
    runs-on: ubuntu-latest

    permissions:
      actions: write
      checks: write
      contents: write
      deployments: write
      issues: write
      packages: write
      pull-requests: write
      repository-projects: write
      security-events: write
      statuses: write
    steps:
      - uses: actions/checkout@v3
      - run: |
          sudo apt-get install -y pandoc
		  for i in $(seq 50 100); do
			pandoc -f markdown -t html --template=mytemplate "./md/article${i}.md" > "./docs/article${i}.html"
		  done
          git config user.name  "github-action"
          git config user.email "github-action@example.com"
          git add ./docs
          git add ./md
          git commit -m "generated"
          git push
```

上記のファイルをpushすれば完成です。

## 解説

```
on: push
jobs:
  build:
    runs-on: ubuntu-latest
```

今回はベーシックなubuntuのコンテナを使います。

```
    permissions:
      actions: write
      checks: write
      contents: write
      deployments: write
      issues: write
      packages: write
      pull-requests: write
      repository-projects: write
      security-events: write
      statuses: write
```
こちらは、github actionからgitでcommitするために必要な記述だったので追記します。

```
    steps:
      - uses: actions/checkout@v3
      - run: |
          sudo apt-get install -y pandoc
```

pandocを利用するためにインストールします。

```
		  for i in $(seq 1 100); do
			pandoc -f markdown -t html --template=mytemplate "./md/article${i}.md" > "./docs/article${i}.html"
		  done
```

mdファイルを予め命名を規則的にしておきループするようにします。
(ただ、ディレクトリにあるファイルにすべて処理するとかのほうがホントは良さそう)


```
          git config user.name  "github-action"
          git config user.email "github-action@example.com"
          git add ./docs
          git commit -m "generated"
          git push
```
最後に生成されたファイルをコミットします。

以上