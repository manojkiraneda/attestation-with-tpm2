#!/usr/bin/env bash
set -exo pipefail

# Generate CSR
openssl req -new -provider tpm2 -key handle:0x81000000 -subj "/CN=IBM Platform/O=IBM/C=US"  -out platform.csr

# Generate CA signed client cert
rm -rf ca 2> /dev/null
mkdir ca 2> /dev/null
touch ca/index.txt
touch ca/index.txt.attr
echo 'unique_subject = no' >> ca/index.txt.attr
echo '01' > ca/serial
(yes || true) | openssl ca -config config -in platform.csr -out platform.pem

# Convert the pem to der
openssl x509 -in platform.pem -outform der -out platform.der

# Read cert
openssl x509 -in platform.der -inform der -text -noout
