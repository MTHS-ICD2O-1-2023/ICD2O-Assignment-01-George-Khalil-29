#!/bin/bash

# now update the README.md file
GITHUB_URL=$(git remote get-url origin)
#GITHUB_USER=$(git config user.name)
GITHUB_REPO_NAME=$(basename -s .git "$(git config --get remote.origin.url)")

# from: https://serverfault.com/questions/417241/extract-repository-name-from-github-url-in-bash

re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+)(.git)*$"

if [[ $GITHUB_URL =~ $re ]]; then
    #PROTOCOL=${BASH_REMATCH[1]}
    #SEPERATOR=${BASH_REMATCH[2]}
    HOSTNAME=${BASH_REMATCH[3]}
    GITHUB_REPO_OWNER=${BASH_REMATCH[4]}
    #REPO=${BASH_REMATCH[5]}
fi

FIRST_CHAR=$(head -c 1 ./README.md)
if [ "$FIRST_CHAR" = "[" ]
then
    cp ./.devcontainer/.bashrc ~/.bashrc
    ex -s -c 1m3 -c w -c q ./README.md
    sed -i "3G" ./README.md
    sed -i "s/<OWNER>/$GITHUB_REPO_OWNER/g" ./README.md
    sed -i "s/<REPOSITORY>/$GITHUB_REPO_NAME/g" ./README.md
    git add -A
    git commit -m "updated the badges"
    git push origin main
    # shellcheck disable=SC1090
    source ~/.bashrc 
    echo "README.md updated."
elif [ "$FIRST_CHAR" = "#" ]
then
    echo "Already changed."
else
    echo "Not what it should be!"
fi