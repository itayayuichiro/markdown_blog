---
title: [Trick] Automatically generate html file from markdown file with github action
---

## overview

It is possible to convert to markdown->html by using [pandoc](https://pandoc-doc-ja.readthedocs.io/ja/latest/users-guide.html), but it was troublesome to do it manually every time. .

## procedure

Create a configuration file like below
.github/workflows/md-to-html.yml

```
on: push
jobs:
  build:
    runs-on: ubuntu-latest

    permissions:
      actions: write
      checks: write
      contents: write
      deployments: write
      issues: write
      packages: write
      pull-requests: write
      repository-projects: write
      security-events: write
      statuses: write
    steps:
      - uses: actions/checkout@v3
      - run: |
          sudo apt-get install -y pandoc
		  for i in $(seq 50 100); do
			pandoc -f markdown -t html --template=mytemplate "./md/article${i}.md" > "./docs/article${i}.html"
		  done
          git config user.name  "github-action"
          git config user.email "github-action@example.com"
          git add ./docs
          git add ./md
          git commit -m "generated"
          git push
```

Just push the above file and you're done.

## Commentary

```
on: push
jobs:
  build:
    runs-on: ubuntu-latest
```

This time we will use a basic ubuntu container.

```
    permissions:
      actions: write
      checks: write
      contents: write
      deployments: write
      issues: write
      packages: write
      pull-requests: write
      repository-projects: write
      security-events: write
      statuses: write
```

This is a necessary description to commit with git from github action, so I will add it.


```
    steps:
      - uses: actions/checkout@v3
      - run: |
          sudo apt-get install -y pandoc
```

Install to use pandoc.

```
		  for i in $(seq 1 100); do
			pandoc -f markdown -t html --template=mytemplate "./md/article${i}.md" > "./docs/article${i}.html"
		  done
```

Name the md files regularly in advance and loop.
(However, it seems better to process all the files in the directory)


```
          git config user.name  "github-action"
          git config user.email "github-action@example.com"
          git add ./docs
          git commit -m "generated"
          git push
```

Commit the last generated file.

that's all