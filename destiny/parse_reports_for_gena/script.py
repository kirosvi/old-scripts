#!/usr/bin/python
import os
from os import listdir
fxrate_file = open("exchange", "r")
fxrate = float(fxrate_file.readline())
fxrate_file.close()
#print fxrate

for file in listdir("."):

    if ".txt" in file:
        aof_sum = 0
        icecreamadventure_sum = 0
        docAndDog_sum = 0
        beastfable_sum = 0
        with open(file, "r") as textfile:
            for line in textfile:
                #print line
                word = line.split('\t')
                if len(word) > 4:
                    if "aof" in word[4]:
                        #print word[4]
                        aof_sum += float(word[7])
                    if "icecreamadventure" in word[4]:
                        #print word[4]
                        icecreamadventure_sum += float(word[7])
                    if "docAndDog" in word[4]:
                        #print word[4]
                        docAndDog_sum += float(word[7])
                    if "beastfable" in word[4]:
                        #print word[4]
                        beastfable_sum += float(word[7])

        all_sum = (aof_sum + icecreamadventure_sum + docAndDog_sum + beastfable_sum) * fxrate

        print('from file- ' + file)
        print('aof_sum- ' + str(aof_sum * fxrate))
        print('ICS- ' + str(icecreamadventure_sum * fxrate))
        print('D&D- ' + str(docAndDog_sum * fxrate))
        print('beastfable- ' + str(beastfable_sum * fxrate))
        print('All- ' + str(all_sum))
        #output = open("itog", "w")
        #output.write('from file- ' + file + '%s\n')
        #output.write('aof_sum- ' + str(aof_sum * fxrate) + '%s\n')
        #output.write('ICS- ' + str(icecreamadventure_sum * fxrate) + '%s\n')
        #output.write('D&D- ' + str(docAndDog_sum * fxrate) + '%s\n')
        #output.write('beastfable- ' + str(beastfable_sum * fxrate) + '%s\n')
        #output.write('All- ' + str(all_sum) + '%s\n')
        #output.close()

#read_table()
