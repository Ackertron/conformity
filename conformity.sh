#!/bin/bash
echo "Setting up conformity..."

pushd /Users/eric.ackerson/code/conformity > /dev/null

for file in private/*.sh; do source $file; done
for file in scripts/*.sh; do source $file; done
for file in source/*.sh; do source $file; done

pathadd $(pwd)/scripts/

popd > /dev/null