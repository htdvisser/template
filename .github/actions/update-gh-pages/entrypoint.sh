#!/bin/sh

set -euo pipefail

source=$(readlink -f "$1")

mkdir /tmp/pages
rsync -acv "${source}"/ /tmp/pages

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git stash push -a
git checkout gh-pages || (git checkout --orphan gh-pages && git rm -r --cached . && git clean -df)

rsync -acv /tmp/pages/ .

if [ -z "$(git status --porcelain)" ]; then exit 0; fi

git add .

git commit -m "Build from ${GITHUB_SHA}"

if [ ! -z "${DEPLOY_KEY}" ]; then
	mkdir /root/.ssh
	ssh-keyscan github.com > /root/.ssh/known_hosts
	echo "${DEPLOY_KEY}" > /root/.ssh/deploy_key
	chmod 400 /root/.ssh/deploy_key
	ssh-agent sh -c "ssh-add /root/.ssh/deploy_key; git push --force git@github.com:${GITHUB_REPOSITORY}.git gh-pages:gh-pages"
else
	deploy_token=${DEPLOY_TOKEN:-GITHUB_TOKEN}
	git push --force "https://x-access-token:${deploy_token}@github.com/${GITHUB_REPOSITORY}.git" gh-pages:gh-pages
fi
