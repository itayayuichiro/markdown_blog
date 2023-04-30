---
title: もっと手軽にChatGPTを扱うためのCLIハック
---

## 方法
https://platform.openai.com/account/api-keys
上記のサイトにアクセスして、APIキーを発行する


```sh
curl https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer 取得したAPIキー" \
  -d '{
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "こんにちは"}]
  }'

```
とcurlでリクエストを打つと

```json
{
  "id": "chatcmpl-7BA6agAmCRdxWVIGCVpKOwPF2y2tp",
  "object": "chat.completion",
  "created": 1682894808,
  "model": "gpt-3.5-turbo-0301",
  "usage": {
    "prompt_tokens": 9,
    "completion_tokens": 24,
    "total_tokens": 33
  },
  "choices": [
    {
      "message": {
        "role": "assistant",
        "content": "こんにちは！私はAIアシスタントです。何かお手伝いできますか？"
      },
      "finish_reason": "stop",
      "index": 0
    }
  ]
}
```

このような形でレスポンスが返ってくる。
contentの部分をいじれば自由にリクエストが可能


## 無料枠について
デフォルトで$5の無料枠があるのでそこまで無料で使える。

https://platform.openai.com/account/usage

このページで自分がどれくらい使ったかも見ることができる。