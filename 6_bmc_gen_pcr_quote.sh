#!/usr/bin/env bash

# -e: exit when any command fails
# -x: all executed commands are printed to the terminal
# -o pipefail: prevents errors in a pipeline from being masked
set -exo pipefail

# Generate the signed quote
tpm2 quote -c 0x81000000 -l sha256:0,1,8,9 -q abc123 -m quote.msg -s quote.sig -o quote.pcrs -g sha256
