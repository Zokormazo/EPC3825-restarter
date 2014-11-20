#!/bin/sh
#ping google.com and restart cisco EPC3825 router if no response

ping -q -c1 google.com > /dev/null

if [ $? -ne 0 ] ; then
	rm /tmp/cookie
	curl -L -c /tmp/cookie -d "username_login=admin" -d "password_login=cisco" -d "login=Log+In" http://192.168.13.1/goform/Docsis_system
	curl --cookie /tmp/cookie --referer http://192.158.13.1/Devicerestart.asp -d "mtenRestore=Device+Restart" -d "devicerestart=1" http://192.168.13.1/goform/Devicerestart
fi
