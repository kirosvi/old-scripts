#!/usr/bin/python
import os, subprocess
from os import listdir
import datetime
from datetime import datetime, date, time
os.chdir(os.getcwd())
#####  DONT FORGET TO CHANGE DATE IN NEXT LINE!!!!!
beastfable_mobi_date = "2016-06-12"
#####
warning_counter = 0
######## sub directory for creating files with whois info
sourcedir = "domain/"
######## constant to modify and format dates from info files
date1 = "paid-till"
date2 = "Registrar Registration Expiration Date:"
date3 = "Registry Expiry Date:"
date4 = "Expiration Date:"
#########dictionary for domains and dates
dict_domains = {}
dict_dates = {}

######## get today date
now_date = str(datetime.today())[:10]
now_date = datetime.strptime(now_date, '%Y-%m-%d').date()

#######create files with info
command = " ".join(("mkdir", sourcedir))
child = subprocess.call(command, executable='/bin/bash', shell=True)

with open("domain_list", "r") as textfile:
    for line in textfile:
        line = line[:-1]
        out_file = sourcedir+line
        command = " ".join(("whois", line, ">>", out_file))
        child = subprocess.call(command, executable='/bin/bash', shell=True)

# insert domain name and date to dictionary dict_domains
for file in listdir(sourcedir):
    dict_domains[file] = ''
    with open(sourcedir+file, "r") as textfile:
        for line in textfile:
            if date1 in line:
                dict_domains[file] = line[len(line)-11:-1].replace(".","-")
            elif date2 in line:
                dict_domains[file] = line[len(line)-21:len(line)-11]
            elif date3 in line:
                dict_domains[file] = line[len(line)-21:len(line)-11]
            elif date4 and "UTC" in line:
                dict_domains[file] = line[len(line)-25:len(line)-13]
        dict_domains['beastfable.mobi'] = beastfable_mobi_date

####### insert domain name and number days to end of domain registration
for i in dict_domains.keys():
    a = dict_domains.get(i)
    if a == "":
        pass
    else:
        d = datetime.strptime(a, '%Y-%m-%d').date()
        delta_date = d - now_date
        dd = str(delta_date)
        dict_dates[i] = (dd.split()[0])

####### get domains with end registration less then 30 days
print "Next Domain registration ends less than 30 days"
for i in dict_dates.keys():
    if int(dict_dates.get(i)) < 30 :
        warning_counter += 1
        print i, dict_dates.get(i), "days left"

# function if want do if domain expiration less than 30 days
"""
if warning_counter > 0 :
    print "Need send email with", warning_counter, "domains"
"""
# get all domain and dates and days to end
"""
print "  "
for i in dict_domains.keys():
    if i == ".DS_Store":
        continue
    else:
        print "Domain reg", i, " ends at ", dict_domains.get(i)," left ", dict_dates.get(i)," days"
"""
