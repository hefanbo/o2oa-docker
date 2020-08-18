#!/bin/sh
URL=$(wget -q -O - http://www.o2oa.net/webSite/download-pro.json | sed -n 's/.*url.*\(http.*linux\.zip\).*/\1/p')
FILE=$(echo $URL | sed -n 's/.*\/\(.*\)/\1/p')
wget -P install_files $URL
