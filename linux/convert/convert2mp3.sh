#!/bin/bash

ffmpeg -i $1 -vn -acodec libmp3lame -ac 2 -ab 192k -ar 48000 $1.mp3
