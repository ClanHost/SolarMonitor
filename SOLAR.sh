#!/bin/bash

SERVICEID=1000
SERVICEPASSWORD=
DEVICE=hidraw0
APIKEY=

while :
do
    MODE=$(mpp-solar -p /dev/$DEVICE --getsettings --output json)
    MODE=${MODE//\\/\\\\} # \
    MODE=${MODE//\//\\\/} # /
    MODE=${MODE//\"/\\\"} # "
    MODE=${MODE//   /\\t} # \t (tab)
    MODE=${MODE///\\\n} # \n (newline)
    MODE=${MODE//^M/\\\r} # \r (carriage return)
    MODE=${MODE//^L/\\\f} # \f (form feed)
    MODE=${MODE//^H/\\\b} # \b (backspace)
    MODE=${MODE//b\'000\'/\ZZZZ} # \b (backspace)
    DATA="{\"ACTION\": \"SETTINGS\", \"APIKEY\": \"$APIKEY\", \"DATA\": \"$MODE\"}"
    printf "SETTINGS\r\n"
    curl -H 'Content-Type:application/json' -X POST https://solar.clanhost.com.au/API/index.php -d "$DATA"
    printf "\r\n"

    MODE=$(mpp-solar -p /dev/$DEVICE --getstatus --output json)
    MODE=${MODE//\\/\\\\} # \
    MODE=${MODE//\//\\\/} # /
    MODE=${MODE//\'/\\\'} # ' (not strictly needed ?)
    MODE=${MODE//\"/\\\"} # "
    MODE=${MODE//   /\\t} # \t (tab)
    MODE=${MODE///\\\n} # \n (newline)
    MODE=${MODE//^M/\\\r} # \r (carriage return)
    MODE=${MODE//^L/\\\f} # \f (form feed)
    MODE=${MODE//^H/\\\b} # \b (backspace)
    DATA="{\"ACTION\": \"STATUS\", \"APIKEY\": \"$APIKEY\", \"DATA\": \"$MODE\"}"
    printf "STATS\r\n"
    curl -H 'Content-Type:application/json' -X POST https://solar.clanhost.com.au/API/index.php -d "$DATA"
    printf "\r\n"

    MODE=$(mpp-solar -p /dev/$DEVICE -c QMOD --output json)
    MODE=${MODE//\\/\\\\} # \
    MODE=${MODE//\//\\\/} # /
    MODE=${MODE//\'/\\\'} # ' (not strictly needed ?)
    MODE=${MODE//\"/\\\"} # "
    MODE=${MODE//   /\\t} # \t (tab)
    MODE=${MODE///\\\n} # \n (newline)
    MODE=${MODE//^M/\\\r} # \r (carriage return)
    MODE=${MODE//^L/\\\f} # \f (form feed)
    MODE=${MODE//^H/\\\b} # \b (backspace)
    DATA="{\"ACTION\": \"MODE\", \"APIKEY\": \"$APIKEY\", \"DATA\": \"$MODE\"}"
    printf "MODE\r\n"
    curl -H 'Content-Type:application/json' -X POST https://solar.clanhost.com.au/API/index.php -d "$DATA"
    printf "\r\n"

    printf "UPDATESETTINGS\r\n"
    curl -s "https://solar.clanhost.com.au/API/?ACTION=UPDATESETTINGS&APIKEY=${APIKEY}" --output MODIFYCONFIG
	
    sh MODIFYCONFIG
    rm MODIFYCONFIG
done
