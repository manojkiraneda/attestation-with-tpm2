#!/usr/bin/env bash
set -exo pipefail

# Generate CA
openssl req -x509 -sha256 -nodes -days 365 -subj "/CN=IBM CA/O=IBM/C=US" -newkey rsa:2048 -keyout local-ca.key -outform der -out local-ca.der

# Read cert
#openssl x509 -in local-ca.crt -text -noout

# Read cert
openssl x509 -in local-ca.der -inform der -text -noout
