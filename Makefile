local: url.bs
	bikeshed spec url.bs url.html --md-Text-Macro="SNAPSHOT-LINK LOCAL COPY"

remote: url.bs
	curl https://api.csswg.org/bikeshed/ -f -F file=@url.bs > url.html -F md-Text-Macro="SNAPSHOT-LINK LOCAL COPY"
