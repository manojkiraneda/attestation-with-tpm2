#!/usr/bin/env bash
set -exo pipefail

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

# Generate CA signed client cert
rm -rf ca 2> /dev/null
mkdir ca 2> /dev/null
touch ca/index.txt
touch ca/index.txt.attr
echo 'unique_subject = no' >> ca/index.txt.attr
echo '02' > ca/serial
(yes || true) | openssl ca -config config -in network_auth.csr -out network_auth.pem

# Convert the pem to der
openssl x509 -in network_auth.pem -outform der -out network_auth.der

# Read cert
openssl x509 -in network_auth.der -inform der -text -noout

