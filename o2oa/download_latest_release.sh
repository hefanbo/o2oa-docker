#!/bin/sh
URL=$(wget -q -O - http://www.o2oa.net/webSite/history.json | sed -n '0,/.*url.*\(http.*linux.*\.zip\).*/s//\1/p')
FILE=$(echo $URL | sed -n 's/.*\/\(.*\)/\1/p')
wget -P install_files $URL
