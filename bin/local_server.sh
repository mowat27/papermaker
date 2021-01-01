#!/usr/bin/env bash

# This script allows is a workaround to make the app visible running from 
# docker containers... assuming the are running on the host network

local_ip="$(ifconfig | grep broadcast | cut -d' ' -f2)"
export DOMAIN_NAME_OVERRIDE=$local_ip

bundle exec rails server -b 0.0.0.0


