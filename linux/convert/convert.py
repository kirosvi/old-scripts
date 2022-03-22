#!/usr/bin/python
#ffmpeg -i input.avi -c:v libx264 -crf 19 -preset slow -c:a aac -strict experimental -b:a 192k -ac 2 out.mp4
#ffmpeg -i input.flac -strict experimental -acodec vorbis -aq 100 output.ogg
import os, subprocess

os.chdir(os.getcwd())
sourcedir = "./"
convert_list = []
f_ext = ".avi"   #extension of source file
f_extnew = ".mp4"   #extension of output file
ffmpeg = "/usr/local/bin/ffmpeg"    # path to ffmpeg
#params = "-strict experimental -acodec vorbis -aq 100"  # settings of converting which in command after source file and before output file
params = "-c:v libx264 -crf 19 -preset slow -c:a aac -strict experimental -b:a 192k -ac 2"
spec_sym = ")(][}{"
""" if spaces in name, it was renamed """
for file in os.listdir(sourcedir):
    os.rename(file, file.replace(" ", "_"))
    for i in range(len(file)):
        if file[i] in spec_sym:
            os.rename(file, file.replace(file[i], "_"))


for file in os.listdir(sourcedir):
    if f_ext in file:
        convert_list.append(file)


for file in convert_list:
    child = subprocess.call(" ".join((ffmpeg, "-i", file, params, file.replace(f_ext, f_extnew))), executable='/bin/bash', shell=True)
