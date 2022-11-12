
include ../base.mk
include templates.mk

.DEFAULT_GOAL := all
.PHONY: all
all: ;

.PHONY: gen
gen:
	@# https://news.ycombinator.com/item?id=30328005
	@# https://gist.github.com/573/e5cf230a03c5d53f848b58c3ced0bc95
	@# https://support.mozilla.org/en-US/questions/920273#answer-313056
	: > import.html
	echo "$$header" >> import.html
	for f in *.js; do \
		echo "            <DT><A HREF=\"$$(cat $$f | tr \" \')\">$${f%.js}</A>" >> import.html; \
	done
	echo "$$footer" >> import.html
