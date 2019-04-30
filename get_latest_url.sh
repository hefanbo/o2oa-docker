#!/bin/sh
curl -s http://collect.o2oa.net:20080/o2_collect_assemble/jaxrs/update/latest/version | tr -d '[:blank:]' | sed -n -e 's/.*url":"\(.*versions\/\)\(.*\)\.zip"/\1o2server_\2_linux.zip/p'
