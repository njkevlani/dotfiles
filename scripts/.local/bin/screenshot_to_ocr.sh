#!/usr/bin/env bash

# Taken from https://willbush.netlify.app/blog/fast-ocr-to-clipboard/

flameshot gui -s --raw |
	tesseract stdin stdout -l eng |
	xclip -in -selection clipboard
