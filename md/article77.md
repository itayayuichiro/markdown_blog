---
title: "Requirements installation failed with status: 1.の対応法"
---

## 概要

RVMのインストールを行おうとしたら下記のようなエラーが表示された
```
Searching for binary rubies, this might take some time.
Found remote file https://rvm.io/binaries/osx/10.9/x86_64/ruby-2.1.1.tar.bz2
Checking requirements for osx.
About to install Homebrew, press `Enter` for default installation in `/usr/local`,
type new path if you wish custom Homebrew installation (the path needs to be writable for user)
: Requirements installation failed with status: 1.
```

## 対応法
この事象が起こる原因は色々あるようですが私の場合は自分でHomebrewをインストールする必要がありました。

これはbrew.shからのコマンドを使用しています：

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

その後、RVMのインストールコマンドを再度実行すると、正常に動作しました。

どうやら、RVMは何らかの理由で私のマシンにHomebrewをインストールする際に問題があったようです。
