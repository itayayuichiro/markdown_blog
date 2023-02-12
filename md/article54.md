---
title: BUILD FAILED (macOS 11.4 using ruby-build 20230208.1)対処法
---

## 概要

```
rbenv install 3.2.1
```
を実行したところ下記のようなエラーが出た

```
To follow progress, use 'tail -f /var/folders/19/c1__d35d5jg150mc700fgfm80000gn/T/ruby-build.20230212124132.58816.log' or pass --verbose
Downloading openssl-3.0.8.tar.gz...
-> https://dqw8nmjcqpjn7.cloudfront.net/6c13d2bf38fdf31eac3ce2a347073673f5d63263398f1f69d0df4a41253e4b3e
Installing openssl-3.0.8...
Installed openssl-3.0.8 to /Users/xxx/.rbenv/versions/3.2.1

Downloading ruby-3.2.1.tar.gz...
-> https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.1.tar.gz
Installing ruby-3.2.1...
ruby-build: using readline from homebrew
ruby-build: using gmp from homebrew

BUILD FAILED (macOS 11.4 using ruby-build 20230208.1)

Inspect or clean up the working tree at /var/folders/19/c1__d35d5jg150mc700fgfm80000gn/T/ruby-build.20230212124132.58816.7pCUnp
Results logged to /var/folders/19/c1__d35d5jg150mc700fgfm80000gn/T/ruby-build.20230212124132.58816.log

Last 10 log lines:
	Check ext/psych/mkmf.log for more details.
*** Fix the problems, then remove these directories and try again if you want.
Generating RDoc documentation
/private/var/folders/19/c1__d35d5jg150mc700fgfm80000gn/T/ruby-build.20230212124132.58816.7pCUnp/ruby-3.2.1/lib/yaml.rb:3: warning: It seems your ruby installation is missing psych (for YAML output).
To eliminate this warning, please install libyaml and reinstall your ruby.
uh-oh! RDoc had a problem:
cannot load such file -- psych
```

エラー文を読んでも全く解決策がわからなかったので記事を書いた

## うまくいかなかった方法
下記の2つのやり方ではうまくいきませんでした。

```
RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC rbenv install 3.2.1

or

RUBY_CFLAGS="-w" rbenv install 3.2.1
```

## うまくいった方法

```
brew install libyaml
```

を行ってから

```
rbenv install 3.2.1
```
を実行




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
