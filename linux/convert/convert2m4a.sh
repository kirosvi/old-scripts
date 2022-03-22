#!/bin/bash

ffmpeg -i $1 -vn -c:a aac -strict -2 -b:a 64k $1.m4a
