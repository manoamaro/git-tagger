#!/bin/sh
set -e

SSH_PATH="$HOME/.ssh"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$GIT_PRIVATE_KEY" | openssl base64 -A -d > "$SSH_PATH/id_rsa"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/id_rsa"

eval $(ssh-agent)

ssh-add "$SSH_PATH/id_rsa"

ssh-keyscan -t rsa $GIT_HOST >> "$SSH_PATH/known_hosts"

git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_EMAIL

git clone $GIT_REPO -b $GIT_REF --no-tags --single-branch ./repo

cd ./repo

git tag $TAG_NAME

git push --force origin $TAG_NAME

exec "$@"