#!/bin/bash

set -Eeuo pipefail

git submodule init
git submodule update

pushd static/tiny-essay-editor

cat << EOF > .env
VITE_OPENAI_API_KEY=invalid-api-key
VITE_SYNC_SERVER_URL=wss://cloud/automerge-sync/
VITE_SYNC_SERVER_STORAGE_ID=3760df37-a4c6-4f66-9ecd-732039a9385d
EOF

yarn && yarn build
popd

echo "Success!"