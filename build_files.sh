#!/bin/bash
FILE="$1"
BASENAME=`basename "$FILE"`
DIR="$2"
pushd .
cd "$DIR"
COMMITS="$( (git log --no-decorate --format=format:$'%h\t%ad' --date=iso8601-strict -- "$1" && echo) | tee )"
>&2 echo "$COMMITS"
parallel --colsep='\t' 'CONTENTS=$(git show {1}:'"${FILE@Q}"'); test $? -eq 0 && (tee <<< "$CONTENTS" > '"${BASENAME@Q}"'."$(date --date={2} +%s)") || true' <<< "$COMMITS"
popd
for f in "$DIR/$BASENAME".[[:digit:]]*; do mv "$f" dist; done
