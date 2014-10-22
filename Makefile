BIKESHED = bikeshed

all: url.html

url.html: url.src.html
	$(BIKESHED) spec
