#!/usr/bin/env bash
set -exo pipefail

# Generate CSR
openssl req -new -provider tpm2 -key handle:0x81000000 -subj "/CN=IBM Platform/O=IBM/C=US"  -out platform.csr

# Generate CSR
openssl req -new -provider tpm2 -key handle:0x81000001 -subj "/CN=IBM Network auth/O=IBM/C=US"  -out network_auth.csr
