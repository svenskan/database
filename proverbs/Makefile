URL := https://en.wikiquote.org/wiki/Swedish_proverbs

all:
	rm -f database.html
	$(MAKE) update

update: database.csv

database.csv: database.json bin/csv
	bundle exec bin/csv $< > $@

database.json: database.html bin/json
	bundle exec bin/json $< > $@

database.html:
	\curl ${URL} > $@

.PHONY: all update
