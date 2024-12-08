#!/bin/bash

light=$(brightnessctl g)
echo "$(($light/15))%"
