#!/bin/bash
date=`date +%F`
namebackup1="docsfiles_$date"
tar -czf /mnt/backups/1/docs/$namebackup1.tgz /mnt/shares/Docs/
namebackup2="notebooksfiles_$date"
tar -czf /mnt/backups/1/notebooks/$namebackup2.tgz /mnt/shares/notebooks/

#gpg -e -r dlisovsky@ddestiny.ru /mnt/backups/1/docs/$namebackup1.tgz
#gpg -e -r dlisovsky@ddestiny.ru /mnt/backups/1/notebooks/$namebackup2.tgz
#mv /mnt/backups/1/docs/$namebackup1.tgz.gpg /mnt/backups/2/docs/
#mv /mnt/backups/1/notebooks/$namebackup2.tgz.gpg /mnt/backups/2/notebooks/

#rsync -arvz /mnt/backups/2/docs root@10.1.20.12:/mnt/docnet/
#rsync -arvz /mnt/backups/2/notebooks root@10.1.20.12:/mnt/docnet/
