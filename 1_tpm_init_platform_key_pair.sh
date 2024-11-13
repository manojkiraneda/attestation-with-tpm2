#!/usr/bin/env bash
set -exo pipefail

# create primary key under owner hierarchy
tpm2_createprimary -G ecc -c primary.ctx
# make primary key persisted at handle 0x81000000
tpm2_evictcontrol -c primary.ctx 0x81000000
# remove all transient objects
tpm2_flushcontext -t
# create and output an rsa keypair (rsakey.pub, rsakey.priv) which is protected by the primary key
tpm2_create -G rsa3072 -a "fixedtpm|fixedparent|sensitivedataorigin|userwithauth|decrypt|sign|noda" -C 0x81000000 -u platform.pub -r platform.priv
# remove all transient objects
tpm2_flushcontext -t
# load the rsa keypair into tpm 
tpm2_load -C primary.ctx -u platform.pub -r platform.priv -c platform.ctx
# make rsa keypair persisted at handle 0x81000001
tpm2_evictcontrol -c platform.ctx 0x81000001
# remove all transient objects
tpm2_flushcontext -t
