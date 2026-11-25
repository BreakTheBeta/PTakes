#!/usr/bin/env bash
# Everything that can be checked without a watch: the bridge's own tests, the
# protocol's three generated copies, and a real Pebble build. Stages the
# installable bundle in dist/.
set -euo pipefail

cd "$(dirname "$0")"
APP=PTakes

echo "==> syntax"
node --check "src/pkjs/index.js"

echo "==> protocol"
node "test/protocol.test.js"

echo "==> bridge"
node "test/bridge.test.js"

echo "==> build"
pebble build

mkdir -p dist
cp "build/$APP.pbw" "dist/$APP.pbw"
echo "==> wrote dist/$APP.pbw"
