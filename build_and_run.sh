#!/bin/bash
docker kill crsearch_container
docker rm crsearch_container
docker build -t crsearch - < Dockerfile
docker run -it -p 9000:8888  --mount src="$(pwd)",target=/commonroad-search,type=bind --name crsearch_container crsearch
echo ==============
