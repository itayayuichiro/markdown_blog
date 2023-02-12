---
title: BUILD FAILED (macOS 11.4 using ruby-build 20230208.1) Workaround
---

## overview

```
rbenv install 3.2.1
```
I got the following error when running

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
/private/var/folders/19/c1__d35d5jg150mc700fgfm80000gn/T/ruby-build.20230212124132.58816.7pCUnp/ruby-3.2.1/lib/yaml.rb:3: warning: It seems your ruby installation is missing psych (for YAML output) .
To eliminate this warning, please install libyaml and reinstall your ruby.
uh-oh! RDoc had a problem:
cannot load such file -- psych
```

I wrote an article because I didn't understand the solution at all even after reading the error statement

## How it didn't work
The two methods below didn't work.

```
RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC rbenv install 3.2.1

or

RUBY_CFLAGS="-w" rbenv install 3.2.1
```

## How it worked

```
brew install libyaml
```

after doing

```
rbenv install 3.2.1
```
run




### other articles
- [Railsのルーティングでresoucesだけでなくresouceもとても便利だった話 | 昼寝王子のエンジニアブログ](./article49.html)
- [SlimからVueへの書き換える際のチートシート | 昼寝王子のエンジニアブログ](./article50.html)
- [Qiita Advent Calendar 2022で完走賞をとった話 | 昼寝王子のエンジニアブログ](./article51.html)
- [【2023年】世界一やさしいCypress環境構築手順 | 昼寝王子のエンジニアブログ](./article52.html)
- [rbenvを用いて最新のRubyをインストールする方法 | 昼寝王子のエンジニアブログ](./article53.html)
- [BUILD FAILED (macOS 11.4 using ruby-build 20230208.1)対処法 | 昼寝王子のエンジニアブログ](./article54.html)
