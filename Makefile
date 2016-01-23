URL := https://en.wikiquote.org/wiki/Swedish_proverbs

convert: database.html
	./convert.rb $<

database.html:
	\curl ${URL} > database.html
