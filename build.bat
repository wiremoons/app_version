@echo off
rem Use below also from Powershell 7.x
rem odin build . -define:BUILDTS="$(date)" -strict-style -vet
odin build . -define:BUILDTS="%date%" -strict-style -vet
