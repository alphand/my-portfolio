#!/bin/sh

APP_DIR = "/users/nodejs/apps/nikod-portfolio"
# APP_DIR=../test


if [[ ! -d "$APP_DIR/releases" ]]; then
  mkdir -p "$APP_DIR/releases" "$APP_DIR/shared/node_modules"
fi

relname=$(date +"%Y%m%d%H%M%S")
mkdir "$APP_DIR/releases/$relname"
ln -s "$APP_DIR/shared/node_modules" "$APP_DIR/releases/$relname/node_modules"

cp -rf ./* "$APP_DIR/releases/$relname"

idx=0
for f in $(ls -xt $APP_DIR/releases | grep '^[0-9]*'); do
  
  if [[ $idx > 5 ]]; then
    rm -rf "$APP_DIR/releases/$f"
    printf "FILE #$idx: '%s' deleted\n" "$f"
  else
    printf "FILE #$idx: '%s'\n" "$f"  
  fi

  ((idx=idx+1))
done

if [[ -L  "$APP_DIR/current" ]]; then
  rm "$APP_DIR/current"
fi

ln -s "$APP_DIR/releases/$relname" "$APP_DIR/current"
`