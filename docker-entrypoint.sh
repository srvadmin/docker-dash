#!/bin/bash
set -e

mkdir -p "$DASH_DATA"

if [[ ! -s "$DASH_DATA/dash.conf" ]]; then
    cat <<-EOF > "$DASH_DATA/dash.conf"
		printtoconsole=1
		rpcallowip=::/0
    txindex=1
    testnet=${TESTNET:-0}
    rpcuser=${RPCUSER:-dashuser}
    rpcpassword=${RPCPASSWORD:-minex}
    rpcport=${RPCPORT:-8999}
		EOF
		chown dash:dash "$DASH_DATA/dash.conf"
fi

# ensure correct ownership and linking of data directory
# we do not update group ownership here, in case users want to mount
# a host directory and still retain access to it
chown -R dash "$DASH_DATA"
ln -sfn "$DASH_DATA" /home/dash/.dash
chown -h dash:dash /home/dash/.dash

if [ $# -eq 0 ]; then
  exec gosu dash dashd "$@"
else
  exec "$@"
fi
