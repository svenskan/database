URL := https://en.wikiquote.org/wiki/Swedish_proverbs

all:
	rm -f database.html
	$(MAKE) update

update: database.json bin/csvize.rb
	bundle exec bin/csvize.rb $< database

database.json: database.html bin/jsonize.rb
	bundle exec bin/jsonize.rb $< > $@

database.html:
	\curl ${URL} > database.html

.PHONY: all update
