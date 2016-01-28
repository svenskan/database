URL := https://en.wikibooks.org/wiki/Swedish/List_of_strong_and_irregular_verbs

all:
	rm -f database.html
	$(MAKE) update

update: database.csv

database.csv: database.json bin/csv.rb
	bundle exec bin/csv.rb $< > $@

database.json: database.html bin/json.rb
	bundle exec bin/json.rb $< > $@

database.html:
	\curl ${URL} > $@

.PHONY: all update
