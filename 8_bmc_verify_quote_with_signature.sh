#!/usr/bin/env bash

# -e: exit when any command fails
# -x: all executed commands are printed to the terminal
# -o pipefail: prevents errors in a pipeline from being masked
set -exo pipefail

openssl x509 -pubkey -noout -in platform.pem > platform-public-key.pem

# verify quote aganist the signature & the nonce
tpm2_checkquote -u platform-public-key.pem -m quote.msg -s quote.sig -f quote.pcrs -g sha256 -q abc123
