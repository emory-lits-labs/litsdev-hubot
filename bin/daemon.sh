#!/bin/sh

# hubot daemon script from http://www.freshblurbs.com/blog/2013/06/16/hubot-hipchat-daemon.html

USER_HOME="/home/$USER"
HUBOT_ROOT="$USER_HOME/hubot"
HUBOT_HOME="$HUBOT_ROOT/node_modules/hubot"
DAEMON="$HUBOT_HOME/bin/hubot"
PIDFILE=$HUBOT_ROOT/hubot.pid

case "$1" in
start)
        echo "Starting"
        . $HUBOT_ROOT/bin/.hubotrc
        /sbin/start-stop-daemon --start --background --pidfile $PIDFILE --make-pidfile -d $HUBOT_ROOT --exec $DAEMON
        echo "."
        ;;
debug)
        echo "Debug mode: no backgrounding"
        . $HUBOT_ROOT/bin/.hubotrc
        /sbin/start-stop-daemon --start --pidfile $PIDFILE --make-pidfile -d $HUBOT_ROOT --exec $DAEMON
        echo "."
        ;;        
stop)
        echo "Stopping"
        /sbin/start-stop-daemon --stop --pidfile $PIDFILE
        echo "."
        ;;  
restart)
        echo "Restarting"
        /sbin/start-stop-daemon --stop --pidfile $PIDFILE
        . $HUBOT_ROOT/bin/.hubotrc
        /sbin/start-stop-daemon --start --pidfile $PIDFILE --make-pidfile --background -d $HUBOT_ROOT --exec $DAEMON
        echo "."
        ;;


    *)
        echo "Usage: $0 {start|stop|restart|debug}" >&2
        exit 1
        ;;  
    esac
    exit
