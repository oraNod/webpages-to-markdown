#!/bin/bash

# Check that the output directory matches the target directory in the playbook.
output=./markdown/images

mkdir -p $output

while IFS= read -r url; do
    curl -L "$url" -o "$output/$(basename $url)"
done < image-urls.txt
