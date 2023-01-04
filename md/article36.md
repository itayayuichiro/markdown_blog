---
title: 【裏技】GoogleのPlaces APIで電話番号検索を行う方法
---

## 概要

PlacesAPIで電話番号での検索を実現する方法を記載。

## 前提
検索でよく使うPlacesAPIだが、特定の電話番号で検索をしたい場合一見できないように見える。
実際、nearbysearchではパラメータとしてlocation情報を必要とするためこちらではできない。

https://developers.google.com/maps/documentation/places/web-service/search-nearby

## やり方

使うのはこちらの「textsearch」である。
https://developers.google.com/maps/documentation/places/web-service/search-text

こちらでは自由にテキストを入力として受け取ることができるので、

```
https://maps.googleapis.com/maps/api/place/textsearch/json?query=03-3886-3388&key=APIキー
```

といった形でリクエストすると、下記のように電話番号とマッチしたお店の情報などが取得できるのである。

```
{
   "html_attributions" : [],
   "results" : [
      {
         "business_status" : "OPERATIONAL",
         "formatted_address" : "日本、〒120-0011 東京都足立区中央本町２丁目２４−１８",
         "geometry" : {
            "location" : {
               "lat" : 35.767735,
               "lng" : 139.809392
            },
            "viewport" : {
               "northeast" : {
                  "lat" : 35.76907192989272,
                  "lng" : 139.8107874798928
               },
               "southwest" : {
                  "lat" : 35.76637227010728,
                  "lng" : 139.8080878201073
               }
            }
         },
         "icon" : "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png",
         "icon_background_color" : "#FF9E67",
         "icon_mask_base_uri" : "https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet",
         "name" : "珍來 五反野駅前店",
         "opening_hours" : {
            "open_now" : true
         },
         "photos" : [
            {
               "height" : 2769,
               "html_attributions" : [
                  "\u003ca href=\"https://maps.google.com/maps/contrib/109670828805592726830\"\u003eA Google User\u003c/a\u003e"
               ],
               "photo_reference" : "ARywPAKG3PBTBUB6xQc5mQPQ3P6TnNLa8DkY2Pligu0sEGEb0UQTJ9cB-_SstuxuDrG4hsd_fTUauZ9wifJOU6lSio1JZlOpKRGOzCpOohdKMwUn8tLB0hoD_NrL8zX-9OudQbji9acWAlHfeL2sDMLeZ50l7ZVClRqkthUv3G_3veKAPjo",
               "width" : 3693
            }
         ],
         "place_id" : "ChIJPSmg9y2OGGARU4R1l_aY-zM",
         "plus_code" : {
            "compound_code" : "QR95+3Q 足立区、東京都",
            "global_code" : "8Q7XQR95+3Q"
         },
         "price_level" : 2,
         "rating" : 3.9,
         "reference" : "ChIJPSmg9y2OGGARU4R1l_aY-zM",
         "types" : [
            "meal_takeaway",
            "restaurant",
            "food",
            "point_of_interest",
            "establishment"
         ],
         "user_ratings_total" : 315
      }
   ],
   "status" : "OK"
}
```

