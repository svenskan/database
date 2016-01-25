URL := https://en.wikiquote.org/wiki/Swedish_proverbs

process: database.json bin/csvize.rb
	bundle exec bin/csvize.rb $< database

update:
	rm -f database.html
	$(MAKE) process

database.json: database.html bin/jsonize.rb
	bundle exec bin/jsonize.rb $< > $@

database.html:
	\curl ${URL} > database.html

.PHONY: process update
