#!/bin/bash
set -e

SHORTNAME=`git config --local remote.origin.url | sed -n "s#.*/\([^.]*\)\.git#\1#p"`
INPUT_FILE=`find . -name "*.bs"`

LS_URL="https://$SHORTNAME.spec.whatwg.org/"
COMMIT_URL_BASE="https://github.com/whatwg/$SHORTNAME/commit/"
BRANCH_URL_BASE="https://github.com/whatwg/$SHORTNAME/tree/"
WEB_ROOT="$SHORTNAME.spec.whatwg.org"
COMMITS_DIR="commit-snapshots"
BRANCHES_DIR="branch-snapshots"

SERVER="75.119.197.251"
SERVER_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDM6WJlvCc/+Zy2wrdzfKMv0Mb2Pmf9INvJPOH/zFrG5TbrKWY2LbNB6m3kkYTDQJzc0EuxCytuDsGhTuzTgc3drHwe2dys7cUQyQzS0iue50r6nBMfr1x2h6WhV3OZHkzFgqS17vlVdlLcGHCCwYgm19TGlrqY5RDnE+jTEAC/9AN7YFbbyfZV5fzToXwA2sFyj9TtwKfu/EeZAInPBpaLumu/glhr+rFXwhQQdNFh7hth8b4flG5mOqODju94wtbuDa4Utw1+S/zCeFIU55R7JHa29Pz3rL6Rpiiin9SpenjkD3UpP+y8WC1OaMImEh1XNUuomQa+6qxXEjxQAW1r"

if [ "$1" != "--local" -a "$DEPLOY_USER" == "" ]; then
    echo "No deploy credentials present; skipping deploy"
    exit 0
fi

if [ "$1" == "--local" ]; then
    echo "Running a local deploy into $WEB_ROOT directory"
    echo ""
fi

SHA="`git rev-parse HEAD`"
BRANCH="`git rev-parse --abbrev-ref HEAD`"
if [ "$BRANCH" == "HEAD" ]; then # Travis does this for some reason
    BRANCH=$TRAVIS_BRANCH
fi

if [ "$BRANCH" == "master" -a "$TRAVIS_PULL_REQUEST" != "false" -a "$TRAVIS_PULL_REQUEST" != "" ]; then
    echo "Skipping deploy for a pull request; the branch build will suffice"
    exit 0
fi

BACK_TO_LS_LINK="<a href=\"/\" id=\"commit-snapshot-link\">Go to the living standard</a>"
SNAPSHOT_LINK="<a href=\"/commit-snapshots/$SHA/\" id=\"commit-snapshot-link\">Snapshot as of this commit</a>"

echo "Branch = $BRANCH"
echo "Commit = $SHA"
echo ""

rm -rf $WEB_ROOT || exit 0

if [ $BRANCH != "master" ] ; then
    # Branch snapshot, if not master
    BRANCH_DIR=$WEB_ROOT/$BRANCHES_DIR/$BRANCH
    mkdir -p $BRANCH_DIR
    curl https://api.csswg.org/bikeshed/ -f -F file=@$INPUT_FILE -F md-status=LS-BRANCH \
         -F md-warning="Branch $BRANCH $BRANCH_URL_BASE$BRANCH replaced by $LS_URL" \
         -F md-title="$TITLE (Branch Snapshot $BRANCH)" \
         -F md-Text-Macro="SNAPSHOT-LINK $SNAPSHOT_LINK" \
         > $BRANCH_DIR/index.html;
    echo "Branch snapshot output to $WEB_ROOT/$BRANCHES_DIR/$BRANCH"
else
    # Commit snapshot, if master
    COMMIT_DIR=$WEB_ROOT/$COMMITS_DIR/$SHA
    mkdir -p $COMMIT_DIR
    curl https://api.csswg.org/bikeshed/ -f -F file=@$INPUT_FILE -F md-status=LS-COMMIT \
         -F md-warning="Commit $SHA $COMMIT_URL_BASE$SHA replaced by $LS_URL" \
         -F md-title="$TITLE (Commit Snapshot $SHA)" \
         -F md-Text-Macro="SNAPSHOT-LINK $BACK_TO_LS_LINK" \
         > $COMMIT_DIR/index.html;
    echo "Commit snapshot output to $WEB_ROOT/$COMMITS_DIR/$SHA"
    echo ""

    # Living standard, if master
    curl https://api.csswg.org/bikeshed/ -f -F file=@$INPUT_FILE \
         -F md-Text-Macro="SNAPSHOT-LINK $SNAPSHOT_LINK" \
         > $WEB_ROOT/index.html
    cp .htaccess $WEB_ROOT/.htaccess 2>/dev/null || :
    echo "Living standard output to $WEB_ROOT"
fi

echo ""
find $WEB_ROOT -print
echo ""

# Run the HTML checker when building on Travis
if [ "$TRAVIS" == "true" ]; then
    curl -O https://sideshowbarker.net/nightlies/jar/vnu.jar
    /usr/lib/jvm/java-8-oracle/jre/bin/java -jar vnu.jar --skip-non-html $WEB_ROOT
fi

if [ "$1" != "--local" ]; then
    # Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
    ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
    ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
    ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
    ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
    openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
    chmod 600 deploy_key
    eval `ssh-agent -s`
    ssh-add deploy_key

    echo "$SERVER $SERVER_PUBLIC_KEY" > known_hosts
    scp -r -o UserKnownHostsFile=known_hosts $WEB_ROOT $DEPLOY_USER@$SERVER:
fi
