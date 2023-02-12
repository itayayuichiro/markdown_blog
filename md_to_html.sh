#!/bin/bash
for i in $(seq 50 100); do
  pandoc -f markdown -t html --template=mytemplate "./md/article${i}.md" > "./docs/article${i}.html"
done
