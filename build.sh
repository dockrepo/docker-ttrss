#! /bin/bash

docker rmi -f `docker images | grep  "<none>" | awk '{print $3}'`
docker image rm -f zyao89/ttrss
docker build -t zyao89/ttrss .
docker push zyao89/ttrss

