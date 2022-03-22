#!/bin/bash
date=`date +%F`
namebackup1="docsfiles_$date"
gpg -e -r dlisovsky@ddestiny.ru /mnt/backups/1/docs/$namebackup1.tgz
mv /mnt/backups/1/docs/$namebackup1.tgz.gpg /mnt/backups/2/docs/
namebackup2="notebooksfiles_$date"
gpg -e -r dlisovsky@ddestiny.ru /mnt/backups/1/notebooks/$namebackup2.tgz
mv /mnt/backups/1/notebooks/$namebackup2.tgz.gpg /mnt/backups/2/notebooks/

rsync -arvz /mnt/backups/2/docs root@10.1.20.12:/mnt/docnet/
rsync -arvz /mnt/backups/2/notebooks root@10.1.20.12:/mnt/docnet/
root@docnet:~/scripts# less rm-old-arch.sh
#!/bin/bash
find /mnt/backups/1/docs/ -type f -mtime +22 -print0 | xargs -0 rm -f
find /mnt/backups/1/notebooks/ -type f -mtime +22 -print0 | xargs -0 rm -f
