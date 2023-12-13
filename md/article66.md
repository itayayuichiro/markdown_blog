---
title: "rubyでMiniMagick::Imageを使ってpng画像が白黒になってしまう"
---

## 概要
MiniMagick::Imageを使った際に画像が白黒(モノクロ)になってしまうことがある
OSによって起きたり起きなかったりする
理由は裏側で動いているImageMagicに渡っている値が違うことによる模様

## 対応方法
画像のオプションに
```
c.colorspace "sRGB"
```
といった記述を追加する。

## 実際のコード
実際のコードを紹介します。

```ruby
require "mini_magick"
require 'rqrcode'
require 'chunky_png'
qr_code = RQRCode::QRCode.new('URL')

qr_png = qr_code.as_png(
  color: "black",
  fill: "white",
  size: 2000
)

# Open QR-Code image with MiniMagick
qrcode_image = MiniMagick::Image.create do |f|
  f.write(qr_png)
end

# Open logo with MiniMagick and resize it if needed
logo_image = MiniMagick::Image.open("画像パス")
logo_image.resize("600x600")

# Combine both images
result = qrcode_image.composite(logo_image) do |c|
  c.colorspace "sRGB" #←これを追加
  c.compose "Over"
  c.geometry "+700+700"
end

IO.binwrite("./qr.png", result.to_blob.to_s)
```