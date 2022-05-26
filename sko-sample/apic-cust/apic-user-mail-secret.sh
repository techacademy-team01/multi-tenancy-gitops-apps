#!/usr/bin/env bash

oc create secret -n tools generic apic-setup-mail \
  --from-literal MAILTRAP-USER=${MAILTRAP-USER} --from-literal MAILTRAP-PWD=${MAILTRAP_PWD} \
  -o yaml --dry-run=client