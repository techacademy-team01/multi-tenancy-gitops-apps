#!/usr/bin/env bash

oc create secret -n tools generic apic-setup-mail \
  --from-literal MAILTRAP_USER=${MAILTRAP_USER} --from-literal MAILTRAP_PWD=${MAILTRAP_PWD} \
  -o yaml --dry-run=client > apic-setup-mail-user-secret.yaml