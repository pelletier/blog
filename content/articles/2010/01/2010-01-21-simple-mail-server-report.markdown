--- 
title: Simple mail server report
---

Here is a small script I wrote a few minutes ago. It gather some informations
from the local machine and send them by email to the administrator (me).
I plays nice with a @weekly rule in Cron.

It is easily customizable without further explanation. However, I think some
enhancements should be added (multiple recipients, generic information addition
etc.)

~~~ bash
#!/bin/bash

# Configuration
SUBJECT="Server repport of `date +%m.%d.%y`"
EMAIL="root@domain.tld"
MSG="/tmp/weekreport"
touch $MSG

# Uptime
echo "Uptime" >> $MSG
echo "`uptime`" >> $MSG
echo "" >> $MSG

# Disk usage
echo "Disk usage" >> $MSG
echo "==========" >> $MSG
echo "" >> $MSG
echo "`df -h`" >> $MSG
echo "" >> $MSG

# Lighty status
echo "Lighttpd" >> $MSG
echo "========" >> $MSG
echo "`/usr/local/etc/rc.d/lighttpd status`" >> $MSG
echo "" >> $MSG

/usr/bin/mail -s "$SUBJECT" "$EMAIL" < $MSG
rm $MSG
~~~
