#!/usr/local/bin/bash

pages="_source/pages/*"

function recur {
  for page in $@; do
    if [[ -d $page ]]; then recur $page"/*"; continue; fi
    if [[ $page == *".src" ]]; then
      echo "INTERPRETING: $page"
      lua _deployment/template.lua $page
    fi
  done
}

recur $pages
