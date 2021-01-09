#!/usr/bin/env bash

# If system has a single ethernet interface, dont show list
if [[ $(ip -4 addr | grep inet | grep -vEc '127(\.[0-9]{1,3}){3}') -eq 1 ]]; then
    echo
    ip -4 addr | grep -w inet | grep -vE '127(\.[0-9]{1,3}){3}' | awk '{ print "\033[0;31m"$7"\033[0m"": ""\033[0;33m"$2"\033[0m"}'
else
    echo
    ip -4 addr | grep -w inet | grep -vE '127(\.[0-9]{1,3}){3}' | awk '{ print "\033[0;31m"$7"\033[0m"": ""\033[0;33m"$2"\033[0m"}' | nl -s '| '
fi
