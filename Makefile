URL := https://en.wikiquote.org/wiki/Swedish_proverbs

process: database.json bin/csvize.rb
	bin/csvize.rb $< database

update:
	rm -f database.html
	$(MAKE) convert

database.json: database.html bin/jsonize.rb
	bin/jsonize.rb $< > $@

database.html:
	\curl ${URL} > database.html

.PHONY: process update
