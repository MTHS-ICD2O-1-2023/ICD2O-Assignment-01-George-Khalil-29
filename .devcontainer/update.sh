#!/bin/bash

# to run: sudo bash ./.devcontainer/update.sh

# now update the README.md file
GITHUB_URL=$(git remote get-url origin)
IFS='/' read -r var1 var2 var3 var4 var5 <<< "$GITHUB_URL"
echo "$var1"
echo "$var2"
echo "$var3"
echo "$var4"
echo "$var5"
GITHUB_REPO_OWNER=$var4
GITHUB_REPO_NAME=$var5

sed -i "s/<OWNER>/$GITHUB_REPO_OWNER/g" ./README.md
sed -i "s/<REPOSITORY>/$GITHUB_REPO_NAME/g" ./README.md

echo "README.md updated."

cp ./.devcontainer/.bashrc ~/.bashrc
exec bash
