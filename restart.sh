#!/bin/sh
# ping google.com and restart cisco EPC3825 router if no response

# config
ROUTER_URL="http://192.168.13.1"	# root URL to router web page
ROUTER_USERNAME="admin"			# router username
ROUTER_PASSWORD="cisco"			# router password
COOKIE_FILE="/tmp/cookie.test"

ping -q -c1 google.com > /dev/null

if [ $? -ne 0 ] ; then
	if [ ! -f ${COOKIE_FILE} ] ; then
		curl -L -c ${COOKIE_FILE} -d "username_login=${ROUTER_USERNAME}" -d "password_login=${ROUTER_PASSWORD}" -d "login=Log+In" ${ROUTER_URL}/goform/Docsis_system > /dev/null
		curl -L -c ${COOKIE_FILE} /tmp/cookie --referer ${ROUTER_URL}/Devicerestart.asp -d "mtenRestore=Device+Restart" -d "devicerestart=1" ${ROUTER_URL}/goform/Devicerestart > /dev/null
		rm -f ${COOKIE_FILE}
	fi
fi
