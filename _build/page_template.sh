#!/usr/local/bin/bash

pages="_source/pages/*"

function recur {
  for page in $@; do
    if [[ -d $page ]]; then recur $page; continue; fi
    echo "INTERPRETING: $page"
    if [[ $page == *".src" ]]; then
      lua _deployment/template.lua $page
    fi
  done
}

recur $pages
