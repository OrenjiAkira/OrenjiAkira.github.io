PAGES=_source/pages/
TESTS=_tests/*.lua

.PHONY: all

all: markdown dir template css redirect

markdown:
	if luarocks show markdown > out; then \
		echo "you have markdown, carry on..."; \
	else \
		echo "you do not have markdown, now installing..."; \
		luarocks install markdown; \
	fi

dir: assets
	./_build/page_folders.sh ${PAGES}

assets:
	mkdir -pv site/assets/
	#cp _source/assets/* site/assets/

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
