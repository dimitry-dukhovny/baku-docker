FROM python:3.10-alpine
LABEL version="0.10"
LABEL name="baku-docker"
LABEL description="Dockerized baku for blogs"

RUN apk add gcc make musl-dev
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install baku
RUN mkdir /blog
#VOLUME . /blog
WORKDIR /blog
CMD [ "baku", "--build" ]

