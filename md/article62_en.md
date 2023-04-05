---
title: "An error occurred when upgrading from Rails5 to Rails6! A simple way to deal with normalize_filter"
---

## Problem

The processing around routing automatically generated in Rails 5 stopped working due to the version upgrade to Rails 6.


```
NoMethodError: undefined method `[]' for nil:NilClass
/xxxx/.bundle/ruby/2.7.0/gems/actionpack-6.0.6.1/lib/action_dispatch/routing/inspector.rb:85:in `normalize_filter'
/xxxx/.bundle/ruby/2.7.0/gems/actionpack-6.0.6.1/lib/action_dispatch/routing/inspector.rb:65:in `format'
/xxxx/lib/tasks/routes_convert_vue.rake:35:in `block (2 levels) in <top (required)>'
/xxxx/.bundle/ruby/2.7.0/gems/sentry-ruby-5.4.2/lib/sentry/rake.rb:26:in `execute'
/xxxx/.bundle/ruby/2.7.0/gems/rake-12.3.3/exe/rake:27:in `<top (required)>'
```

## Solution

Rewrite the code as follows.

```
all_routes = Rails.application.routes.routes
inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
routes = inspector.format(Formatter.new, {})
```

In the code before the change, ENV['CONTROLLER'] was passed as an argument of the normalize_filter method. However, in Rails 6, the argument of the normalize_filter method must be in hash format, so we need to change it to pass an empty hash {} as the argument.
