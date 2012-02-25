--- 
title: Gunicorn / Django Debian init script
tags:
    - django
---

This is a simple Debian init.d script for my self-hosted Django/Gunicorn
websites. Note that it runs inside a virtualenv (my installed Django versions
are different in each virtualenv). If you have questions: comment this post! 

~~~ bash
#!/bin/sh 

### BEGIN INIT INFO
# Provides:       seismic_web
# Required-Start: $local_fs $syslog
# Required-Stop:  $local_fs $syslog
# Default-Start:  2 3 4 5
# Default-Stop:   0 1 6
# Short-Description: Gunicorn processes for seismic_web
### END INIT INFO

# www-data is the default www user on debian
USER=www-data
NAME="seismic_web"
GUNICORN_RUN="gunicorn_django"
# Confdir: the Django project inside the virtualenv
CONFDIR="/home/thomas/seismic_web/seismic_web"
VENV_ACTIVATION=". ../bin/activate"
RETVAL=0
# PID: I always name my gunicorn pidfiles this way
PID="/tmp/gunicorn_"$NAME".pid"

# source function library
. /lib/lsb/init-functions


start()
{
    echo "Starting $NAME."
    cd $CONFDIR;
    su -c "$VENV_ACTIVATION; $GUNICORN_RUN" $USER && echo "OK" || echo "failed";
}

stop()
{
    echo "Stopping $NAME"
    kill -QUIT `cat $PID` && echo "OK" || echo "failed";
}

reload()
{
    echo "Reloading $NAME:"
    if [ -f $PID ]
    then kill -HUP `cat $PID` && echo "OK" || echo "failed";
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        reload
        ;;
    reload)
        reload
        ;;
    force-reload)
        stop && start
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart}"
        RETVAL=1
esac
exit $RETVAL
~~~
