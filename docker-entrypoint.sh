#!/bin/sh

set -e

if [ -d /root/macaroons/ ]; then
  cp -R /root/macaroons/* /root/.lnd/data/chain/bitcoin/
fi

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for lnd"

  set -- lnd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "lnd" ]; then

  echo "$0: setting data directory to $LIGHTNING_DATA"
  mkdir -p $LIGHTNING_DATA

  set -- "$@" --lnddir="$LIGHTNING_DATA"
fi

echo
exec "$@"


