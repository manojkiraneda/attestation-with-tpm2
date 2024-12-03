#!/usr/bin/env bash

# -e: exit when any command fails
# -x: all executed commands are printed to the terminal
# -o pipefail: prevents errors in a pipeline from being masked
set -exo pipefail

CERT_SIZE=$(stat -c %s local-ca.der)
echo "CA Certificate size is $CERT_SIZE bytes"
tpm2_nvdefine 0x1500018 -C o -s $CERT_SIZE -a "ownerread|ownerwrite|authread|authwrite"
tpm2_nvwrite 0x1500018 -C o -i local-ca.der
tpm2_nvread 0x1500018 | openssl x509 -inform der -text -noout
echo "CA cert stored in NVRAM : 0x1500018"

CERT_SIZE=$(stat -c %s platform.der)
echo "Platform Certificate size is $CERT_SIZE bytes"
tpm2_nvdefine 0x1500019 -C o -s $CERT_SIZE -a "ownerread|ownerwrite|authread|authwrite"
tpm2_nvwrite 0x1500019 -C o -i platform.der
tpm2_nvread 0x1500019 | openssl x509 -inform der -text -noout
echo "Platformcert stored in NVRAM : 0x1500019"

CERT_SIZE=$(stat -c %s network_auth.der)
echo "Network Auth Certificate size is $CERT_SIZE bytes"
tpm2_nvdefine 0x1500020 -C o -s $CERT_SIZE -a "ownerread|ownerwrite|authread|authwrite"
tpm2_nvwrite 0x1500020 -C o -i platform.der
tpm2_nvread 0x1500020 | openssl x509 -inform der -text -noout
echo "Network Auth Cert stored in NVRAM : 0x1500020"
