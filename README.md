# 概要
ブログ管理用リポジトリ

## 環境構築

```
brew install pandoc
```


## html生成

```
pandoc -f markdown -t html --template=mytemplate ./md/xxx.md > ./docs/xxx.html
```

