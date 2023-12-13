---
title: "サイトマップを超簡単に自動生成する方法(Ruby)"
---

## 概要
サイトマップを超簡単に自動生成する方法を紹介

## 環境
Ruby

## 手順
1. gemのインストール
1. コード記述

    ```rb
    require 'sitemap_generator'
    SitemapGenerator::Sitemap.default_host = 'https://example.com'
    SitemapGenerator::Sitemap.public_path = "./" # sitemapを配置する場所(デフォルトはpublic配下)
    SitemapGenerator::Sitemap.compress = false #圧縮するかどうか
    
    SitemapGenerator::Sitemap.create do
      add '/article1.html' # ここに追加したいパスを追加していく
    end
    ```

3. 実行

## 結果

カレントディレクトリにsitemap.xmlが生成される

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
    xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
    xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
    xmlns:video="http://www.google.com/schemas/sitemap-video/1.1"
    xmlns:news="http://www.google.com/schemas/sitemap-news/0.9"
    xmlns:mobile="http://www.google.com/schemas/sitemap-mobile/1.0"
    xmlns:pagemap="http://www.google.com/schemas/sitemap-pagemap/1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml">
    <url>
        <loc>https://example.com</loc>
        <lastmod>2023-12-09T15:24:06+09:00</lastmod>
        <changefreq>weekly</changefreq>
        <priority>1.0</priority>
    </url>
    <url>
        <loc>https://example.com/article1.html</loc>
        <lastmod>2023-12-09T15:24:06+09:00</lastmod>
        <changefreq>weekly</changefreq>
        <priority>0.5</priority>
    </url>
</urlset>
```
