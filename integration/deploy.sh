#!/bin/bash

set -ev

# create payload for release
payload=$(
  jq --null-input \
     --arg tag "$(cat $TRAVIS_BUILD_DIR/integration/tag)" \
     --arg name "$(cat $TRAVIS_BUILD_DIR/integration/title)" \
     --arg body "$(cat $TRAVIS_BUILD_DIR/integration/changelog.md)" \
     '{ tag_name: $tag, name: $name, body: $body, draft: false }'
)
echo "payload is: $payload"

# release to github
upload_url=$(curl -X POST \
    https://api.github.com/repos/$TRAVIS_REPO_SLUG/releases?access_token=$GITHUB_TOKEN \
    --header "Content-Type: application/json" \
    -d "$payload" | jq -r .upload_url | sed -e "s/{?name,label}//")
echo "upload url is: $upload_url"

# release all assets
for item in $(ls build/*.tar.gz build/*.hex build/usedspace.txt)
do
    echo "uploading $item"
    curl "$upload_url?name=$item&access_token=$GITHUB_TOKEN" \
        --header "Content-Type: application/octet-stream" \
        --data-binary @"$item"
done
