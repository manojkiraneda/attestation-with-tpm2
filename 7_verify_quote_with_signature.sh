#!/usr/bin/env bash

# -e: exit when any command fails
# -x: all executed commands are printed to the terminal
# -o pipefail: prevents errors in a pipeline from being masked
set -exo pipefail

# verify quote aganist the signature & the nonce
tpm2_checkquote -u platform.pub -m quote.msg -s quote.sig -f quote.pcrs -g sha256 -q abc123
