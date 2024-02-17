#!/usr/bin/bash

set -e
set -u

. "$HOME/.nvm/nvm.sh"
nvm install "$NODE_VERSION"
rm -rf ~/.nvm/.cache/

npm_major=$( node -e 'console.log(process.argv[1].split(".")[0])' -- "$( npm --version )" )

if (( npm_major < 8 )); then
  # Upgrade npm to use for corepack updates (although it will be turned off soon)
  npm install -g npm@^8.0.0
fi

# Upgrade corepack
npm install -g "corepack${COREPACK_VERSION-}"

# Remove npm that is not from corepack
npm uninstall -g npm
# Enable corepack
corepack enable npm
