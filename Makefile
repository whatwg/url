BIKESHED = bikeshed

all: url.html

url.html: url.bs biblio.json Makefile
	$(BIKESHED) spec
