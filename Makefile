# http://wiki.whatwg.org/wiki/GitHub#Makefile

ANOLIS = anolis

all: url.html ../xref/xrefs/network/url.json

url.html: url.src.html ../xref Makefile
	$(ANOLIS) --w3c-compat-substitutions --xref="../xref" \
	--omit-optional-tags --quote-attr-values --enable=xspecxref \
	--enable=refs $< $@

../xref/xrefs/network/url.json: url.src.html Makefile
	$(ANOLIS) --dump-xrefs=$@ $< /tmp/spec
