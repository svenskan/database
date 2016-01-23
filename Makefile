URL := https://en.wikiquote.org/wiki/Swedish_proverbs

convert: database.json

database.json: database.html convert.rb
	./convert.rb $< > $@

database.html:
	\curl ${URL} > database.html

.PHONY: convert
