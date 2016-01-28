URL := https://en.wikiquote.org/wiki/Swedish_proverbs

all:
	rm -f database.html
	$(MAKE) update

update: database.json bin/csv.rb
	bundle exec bin/csv.rb $< database

database.json: database.html bin/json.rb
	bundle exec bin/json.rb $< > $@

database.html:
	\curl ${URL} > database.html

.PHONY: all update
