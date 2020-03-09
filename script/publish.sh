#!/bin/sh

set -eu

SSH_PATH="$HOME/.ssh"
mkdir "$SSH_PATH"
echo "$DEPLOY_KEY" > "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key"

rsync -avzr -delete \
  --exclude .github --exclude script \
  -e 'ssh -p $CONNECTION_PORT -i $SSH_PATH/deploy_key -o StrictHostKeyChecking=no' \
  $GITHUB_WORKSPACE/ \
  $CONNECTION_STRING:$REMOTE_PATH