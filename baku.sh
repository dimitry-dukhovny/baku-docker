#!/bin/bash
mydir=`dirname ${0}`
myuid=`id -u`
mygid=`id -g`
[ -f ${mydir}/baku.env ] && source ${mydir}/baku.env
blogdir=${blogdir:-${defaultblogdir}}

die() {
  echo Halting
  exit 255
}

bakuinit() {
  docker run --user ${myuid}:${mygid} -v ${blogdir}:/blog ${imagename} baku --init
}

blogcmd() {
  if [ "x${@}x" == "x${defaultparms} x" ]
  then
    docker run --user ${myuid}:${mygid} \
      -v ${blogdir}:/blog ${imagename} baku ${defaultparms}
  else
    nextentry=`docker run --user ${myuid}:${mygid} \
      -v ${blogdir}:/blog ${imagename} baku -p "${@}" 2>&1 | \
      egrep '\.md$' | awk '{print $NF}'`
    ${EDITOR} ${blogdir}/${nextentry} && \
      docker run --user ${myuid}:${mygid} \
        -v ${blogdir}:/blog ${imagename} baku -b
  fi
}

startblog() {
  echo "You do not have a blog in ${blogdir}!"
  echo "Making one..."
  origpath=${PWD}
  cd ${blogdir}
  bakuinit
  read -p "Title [${defaulttitle}] :  " title
  title=${title:-${defaulttitle}}
  read -p "Author [${defaultauthor}] :  " author
  author=${author:-${defaultauthor}}
  read -p "URL [${defaulturl}] :  " url
  url=${url:-${defaulturl}}
  read -p "Description [${defaultdescription}] :  " description
  description=${description:-${defaultdescription}}
  read -p "Style [${defaultstyle}] :  " style
  style=${style:-${defaultstyle}}
  cat > ${blogdir}/blog.cfg << EOF
title = ${title}
author = ${author}
url = ${url}
description = ${description}
style = ${style}
EOF
}

[ -d ${blogdir} ] && echo ${blogdir} exists || mkdir ${blogdir}
[ ! -d ${blogdir} ] && echo failed making ${blogdir} && die 255
[ ! -f ${blogdir}/blog.cfg ] && startblog

blogcmd "${@:-${defaultparms}} "

