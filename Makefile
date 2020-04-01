SHELL=/bin/bash -o pipefail
.PHONY: local remote deploy review

remote: url.bs
	curl https://api.csswg.org/bikeshed/ -f -F file=@url.bs > url.html -F md-Text-Macro="SNAPSHOT-LINK LOCAL COPY"

local: url.bs
	bikeshed spec url.bs url.html --md-Text-Macro="SNAPSHOT-LINK LOCAL COPY"

deploy: url.bs
	curl --remote-name --fail https://resources.whatwg.org/build/deploy.sh
	bash ./deploy.sh

review: url.bs
	curl --remote-name --fail https://resources.whatwg.org/build/review.sh
	bash ./review.sh
