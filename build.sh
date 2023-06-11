#!/bin/zsh

odin build . -define:BUILDTS="$(date '+%a %d %b %Y @ %H:%M:%S %Z')"
