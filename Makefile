URL := https://en.wikiquote.org/wiki/Swedish_proverbs

convert: index.html
	./convert.rb $<

index.html:
	\curl ${URL} > index.html
