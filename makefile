

all: dir css template redirect

dir:
	find _source/*.src | cat

css:
	lua _deployment/css.lua < _source/css/style.css

template:
	find _source/*.src | xargs lua _deployment/template.lua

redirect:
	lua _deployment/redirect.lua

test:
	find *.lua | xargs lua
