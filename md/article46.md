---
title: How to notify start, success and failure in Capistrano
---

## overview
Describes how to notify start, success, and failure in Capistrano

## Solutions

You can send notifications by writing:

```
namespace :deploy do
  task :notice_start do
    # Write the process at the start of deployment
  end
  task :notice_fail do
    # Write the process when the deployment fails
  end
  task :notice_success do
    # Write the process for successful deployment
  end
end
after 'deploy:started', 'deploy:notice_start'
after 'deploy:failed', 'deploy:notice_fail'
after 'deploy:finishing', 'deploy:notice_success'
```