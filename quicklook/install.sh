#!/usr/bin/env bash

cd "$(dirname "$(realpath "$0")")";

mkdir -p ~/Library/QuickLook
cp -r *.qlgenerator ~/Library/QuickLook/
