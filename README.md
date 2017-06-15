This repository hosts the [URL Standard](https://url.spec.whatwg.org/).

### Code of conduct

We are committed to providing a friendly, safe and welcoming environment for all. Please read and
respect the [WHATWG Code of Conduct](https://whatwg.org/code-of-conduct).

### Contribution opportunities

Folks notice minor and larger issues with the URL Standard all the time and we'd love your help
fixing those. Pull requests for typographical and grammar errors are also most welcome.

We'd be happy to mentor you through this process. If you're interested and need help getting
started, leave a comment on the issue or ask around [on IRC](https://wiki.whatwg.org/wiki/IRC).

### Pull requests

In short, change `url.bs` and submit your patch, with a
[good commit message](https://github.com/erlang/otp/wiki/Writing-good-commit-messages). Consider
reading through the [WHATWG FAQ](https://wiki.whatwg.org/wiki/FAQ) if you are new here.

Please add your name to the Acknowledgments section in your first pull request, even for trivial
fixes. The names are sorted lexicographically.

If you want to preview the spec locally, you can either use a locally installed copy of
[Bikeshed](https://github.com/tabatkins/bikeshed) by running `make` or use the HTTP API version by
running `make remote`.

If you want to do a complete "local deploy" including commit and/or branch snapshots, run

```
./deploy.sh --local
```

### Merge policy

If you can commit to this repository, see the
[html repository's TEAM](https://github.com/whatwg/html/blob/master/TEAM.md) for guidelines.

### Tests

Tests can be found in the `url/` directory of
[web-platform-tests](https://github.com/w3c/web-platform-tests).
