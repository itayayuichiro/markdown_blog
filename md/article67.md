---
title: rubyで真ん中にロゴがあるQRコードを生成する方法
---

## 用意するもの
用意するのは下記の2つのgemです。

- mini_magick
- rqrcode


## 実際のコード
早速実際のコードを紹介します。
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
  c.compose "Over"
  c.geometry "+700+700"
end

IO.binwrite("./qr.png", result.to_blob.to_s)
```

## You must have ImageMagick or GraphicsMagick installedと怒られたら

```
brew install imagemagick
```
指摘されているようにImageMagickを入れます。

## 出来上がったQRコード
<img src="./pr.png">

## 参考文献
https://github.com/whomwah/rqrcode/issues/49#issuecomment-1262535284