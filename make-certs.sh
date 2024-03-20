#!/bin/bash

set -Eeuo pipefail

# Source: https://stackoverflow.com/a/58580467

CERTS_DIR=./certs/
TLS_ROOT_CA_KEY=$CERTS_DIR/ca-key.pem #tls-root-ca.key
TLS_ROOT_CA_CRT=$CERTS_DIR/ca.pem #tls-root-ca.crt
TLS_MINE_KEY=$CERTS_DIR/cloud.key #tls-mine.key
TLS_TEMP_CSR=$CERTS_DIR/tempfile.csr
TLS_MINE_CRT=$CERTS_DIR/cloud.crt #tls-mine.crt
OPENSSL_CNF=./openssl.cnf
MY_DOMAIN_NAME=cloud

[[ -d $CERTS_DIR ]] || mkdir -p $CERTS_DIR
[[ -f ./$TLS_ROOT_CA_KEY ]] || openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -subj "/O=Personal Cloud Root Authority/CN=$MY_DOMAIN_NAME" -keyout $TLS_ROOT_CA_KEY -out $TLS_ROOT_CA_CRT
[[ -f ./$TLS_MINE_KEY    ]] || openssl genrsa -out "$TLS_MINE_KEY" 2048
[[ -f ./$TLS_TEMP_CSR    ]] || openssl req -new -key $TLS_MINE_KEY -out $TLS_TEMP_CSR -config $OPENSSL_CNF
[[ -f ./$TLS_MINE_CRT    ]] || openssl x509 -req -days 3650 -in $TLS_TEMP_CSR -CA $TLS_ROOT_CA_CRT -CAkey $TLS_ROOT_CA_KEY -CAcreateserial -extensions v3_req -extfile $OPENSSL_CNF -out $TLS_MINE_CRT
