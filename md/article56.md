---
title: uninitialized constant HTTP (NameError)
---

## 概要

```
crawler_selenium.rb:68:in `block (2 levels) in <main>': uninitialized constant HTTP (NameError)

  http_cookies = driver.manage.all_cookies.each{ |e| e[:expires]=e[:expires].to_s }.map{ |e| HTTP::Cookie.new(e) }
                                                                                                 ^^^^^^^^
	from crawler_selenium.rb:68:in `map'
	from crawler_selenium.rb:68:in `block in <main>'
	from crawler_selenium.rb:67:in `open'
	from crawler_selenium.rb:67:in `<main>'
```