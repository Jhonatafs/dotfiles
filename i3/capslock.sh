#!/usr/bin/env bash

echo "󰪛 $(xset q | grep "Caps" | awk -F' ' '{ print $4 }')"
