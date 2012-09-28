ANOLIS = anolis

all: url.html data/xrefs/network/url.json

url.html: url.src.html data Makefile
	$(ANOLIS) --w3c-compat-substitutions \
	--omit-optional-tags --quote-attr-values --enable=xspecxref \
	--enable=refs $< $@

data/xrefs/network/url.json: url.src.html Makefile
	$(ANOLIS) --dump-xrefs=$@ $< /tmp/spec
