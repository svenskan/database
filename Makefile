URL := https://en.wikiquote.org/wiki/Swedish_proverbs

convert: database.json

update:
	rm -f database.html
	$(MAKE) convert

database.json: database.html jsonize.rb
	./jsonize.rb $< > $@

database.html:
	\curl ${URL} > database.html

.PHONY: convert update
