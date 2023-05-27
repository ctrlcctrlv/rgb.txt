#!/bin/bash
FILE="$1"
BASENAME=`basename "$FILE"`
DIR="$2"
BRANCH="${3:-master}"
pushd .
cd "$DIR"
git checkout "$BRANCH"
COMMITS="$( (git log --no-decorate --format=format:$'%h\t%ad' --date=iso8601-strict -- "$FILE" && echo) )"
>&2 echo "$COMMITS"
parallel -j1 --colsep='\t' 'git format-patch -1 {1} -- '"${FILE@Q}" <<< "$COMMITS"
popd
for f in "$DIR"/*.patch; do mv "$f" dist; done
