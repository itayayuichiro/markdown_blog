---
title: "WindowsでShopify-cliをインストールする方法"
---

## 概要

私は次のコマンドを使用してShopifyアプリCLIをインストールしようとしたところ
```
gem install shopify-cli
```

下記のようなエラーになりますした
```
ERROR:  Error installing shopify-cli:
        "theme-check-language-server.bat" from theme-check conflicts with C:/Ruby27-x64/bin/theme-check-language-server.bat
```

## 対応法
このサイトを訪れてみてください。あなたの役に立つかもしれません。

https://shopify.dev/docs/themes/tools/cli

CLIの以下の手順に従ってください。

### ステップ1：新しい要件のインストール

Shopify CLI 2.xの要件に加えて、Shopify CLI 3.xにはNode.js 14.17.0以上が必要です。macOSを使用している場合は、Shopify CLIの最新バージョンにアップグレードするときに、HomebrewがNode.jsを自動的にインストールします。

要件の完全なリストについては、「Shopify CLIのインストール」を参照してください。

### ステップ2：Shopify CLI 2.xのアンインストール

前のバージョンのShopify CLIをアンインストールすることを検討してください。前のバージョンをアンインストールすることで、2つのバージョンの間での衝突を回避できます。

Shopify CLIの両方のバージョンをインストールしたい場合は、「Shopify CLI 2.xと3.xの両方を使用する方法」を参照して、同じ環境で両方のバージョンを使用する方法を学んでください。

Shopify CLIは、インストールしたパッケージマネージャーを使用してシステムから削除できます：

ターミナル

```
gem uninstall shopify-cli
```

Shopify CLIのレガシーバージョン（0.9.0未満）を使用している場合は、手動でアンインストールする必要があります。

### ステップ3：Shopify CLI 3.xのインストール

Shopify CLIは、一連のNode.jsパッケージとして管理されています：

@shopify/cli
@shopify/theme
macOSではHomebrewを使用してこれらのパッケージをインストールできます。WindowsやLinuxでは、パッケージをグローバルにインストールすることもできます。

注意：apt、Yum、およびRubyGemsのインストールはもはやサポートされていません。

MacOS

Homebrewを使用してmacOSにShopify CLIをインストールできます。

Shopify CLIをインストールする前に、HomebrewにShopifyのサードパーティーリポジトリを追加する必要があります。

ターミナル

```
brew tap shopify/shopify
brew install shopify-cli
```

注意：Homebrewは、Ruby、Node.js、Gitなど、Shopify CLIを実行するためのすべての要件を自動的にインストールします。

WindowsおよびLinux

テーマ用のShopify CLIをインストールするには、コマンドラインを使用して、@shopify/cliと@shopify/themeのNode.jsパッケージをグローバルにインストールします。

ターミナル
```
npm install -g @shopify/cli @shopify/theme
```

### ステップ4：インストールの確認

Shopify CLIが正しくインストールされているかを確認するには、次のコマンドを実行してください：
```
shopify version
```