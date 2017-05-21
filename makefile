PAGES=_source/pages/
TESTS=_tests/*.lua

.PHONY: all

all: dir template css redirect

dir:
	./_build/page_folders.sh ${PAGES}

template:
	./_build/page_template.sh

css:
	lua _deployment/css.lua < _source/css/style.css

redirect:
	lua _deployment/redirect.lua

test:
	find ${TESTS} | xargs lua

clean:
	rm -r site/*
