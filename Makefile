BIKESHED = bikeshed

all: url.html

url.html: url.bs Makefile
	$(BIKESHED) spec
