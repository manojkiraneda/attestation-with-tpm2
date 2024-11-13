#!/usr/bin/env bash

# -e: exit when any command fails
# -x: all executed commands are printed to the terminal
# -o pipefail: prevents errors in a pipeline from being masked
set -exo pipefail

# verify if the public key is indeed signed by the IBM CA
tpm2_nvread 0x1500018 -C o | openssl x509 -inform der -outform pem | openssl verify -CAfile /dev/stdin platform.der
