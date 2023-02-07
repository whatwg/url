This repository hosts the [URL Standard](https://url.spec.whatwg.org/).

## Code of conduct

We are committed to providing a friendly, safe, and welcoming environment for all. Please read and
respect the [WHATWG Code of Conduct](https://whatwg.org/code-of-conduct).

## Contribution opportunities

Folks notice minor and larger issues with the URL Standard all the time and we'd love your help
fixing those. Pull requests for typographical and grammar errors are also most welcome.

We'd be happy to mentor you through this process. If you're interested and need help getting
started, leave a comment on the issue or ask around [on IRC](https://whatwg.org/irc).

## Pull requests

In short, change `url.bs` and submit your patch, with a
[good commit message](https://github.com/whatwg/meta/blob/main/COMMITTING.md). Consider
reading through the [WHATWG FAQ](https://whatwg.org/faq) if you are new here.

If your patch makes normative (behavioral) changes, then
[tests](https://github.com/web-platform-tests/wpt) and the
[jsdom/whatwg-url](https://github.com/jsdom/whatwg-url) implementation will need to be updated as
well (see "Tests and implementations" below). Not all of this is necessarily on you.

Please add your name to the Acknowledgments section in your first pull request, even for trivial
fixes. The names are sorted lexicographically.

## Building "locally"

For quick local iteration, run `make`. To verify your changes locally, run `make deploy`. See more
in the
[WHATWG Contributor Guidelines](https://github.com/whatwg/meta/blob/main/CONTRIBUTING.md#building).

## Merge policy

If you can commit to this repository, see the
[WHATWG Maintainer Guidelines](https://github.com/whatwg/meta/blob/main/MAINTAINERS.md).

## Tests and implementations

Tests can be found in the `url/` directory of
[web-platform-tests/wpt](https://github.com/web-platform-tests/wpt). A dashboard showing the tests
running against major browsers can be seen at [wpt.fyi](https://wpt.fyi/results/url).

A complete JavaScript implementation of the standard can be found at
[jsdom/whatwg-url](https://github.com/jsdom/whatwg-url). This implementation is kept synchronized
with the standard and tests.

A complete C++ implementation of the standard can be found at
[ada-url/ada](https://github.com/ada-url/ada). This implementation is kept synchronized
with the standard and tests, and is currently used in [Node.js](https://github.com/nodejs/node).

The [Live URL Viewer](https://jsdom.github.io/whatwg-url/) lets you manually test-parse any URL,
comparing your browser's URL parser to that of
[jsdom/whatwg-url](https://github.com/jsdom/whatwg-url).
