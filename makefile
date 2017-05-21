PAGE_SOURCES=_source/*.src

.PHONY: all

all: dir css template redirect

dir:
	for file in ${PAGE_SOURCES}; do \
		filename=$$(basename $$file .src); \
		dirname=$$(echo $$filename | sed -E "s/$$filename/site\/$$filename/"); \
		if [[ $$dirname == "site/index" ]]; then continue; fi; \
		mkdir -p $$dirname; done

css:
	lua _deployment/css.lua < _source/css/style.css

template:
	find ${PAGE_SOURCES} | xargs lua _deployment/template.lua

redirect:
	lua _deployment/redirect.lua

test:
	find *.lua | xargs lua
