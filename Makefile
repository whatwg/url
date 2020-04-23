SHELL=/bin/bash -o pipefail
.PHONY: local remote deploy review

remote: url.bs
	@ (HTTP_STATUS=$$(curl https://api.csswg.org/bikeshed/ \
	                       --output url.html \
	                       --write-out "%{http_code}" \
	                       --header "Accept: text/plain, text/html" \
	                       -F die-on=warning \
	                       -F md-Text-Macro="COMMIT-SHA LOCAL COPY" \
	                       -F file=@url.bs) && \
	[[ "$$HTTP_STATUS" -eq "200" ]]) || ( \
		echo ""; cat url.html; echo ""; \
		rm -f url.html; \
		exit 22 \
	);

local: url.bs
	bikeshed spec url.bs url.html --md-Text-Macro="COMMIT-SHA LOCAL COPY"

deploy: url.bs
	curl --remote-name --fail https://resources.whatwg.org/build/deploy.sh
	bash ./deploy.sh

review: url.bs
	curl --remote-name --fail https://resources.whatwg.org/build/review.sh
	bash ./review.sh
