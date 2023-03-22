#!/bin/bash
for i in $(seq 50 100); do
  if [ -e "./md/article${i}.md" ]; then
    pandoc -f markdown -t html --template=mytemplate "./md/article${i}.md" > "./docs/article${i}.html"
  fi
  if [ -e "./md/article${i}_en.md" ]; then
    pandoc -f markdown -t html --template=mytemplate "./md/article${i}_en.md" > "./docs/article${i}_en.html"
  fi
done
