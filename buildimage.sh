#!/bin/bash

mydir=`dirname ${0}`
[ -f ${mydir}/baku.env ] && source ${mydir}/baku.env
cd ${mydir}
chmod +x *.sh
docker build -t ${imagename}:latest . && \
  echo "DONE.  Use ${mydir}/baku.sh ." || \
  echo "ERROR:  Build failure for ${imagename}"

