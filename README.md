# What is it?
This repository provides a dockerfile to simplify the setup of CommonRoad-Search (https://gitlab.lrz.de/tum-cps/commonroad-search).

# Installation
## 1. Install docker
You can find installation instructions for Ubuntu at
https://linuxize.com/post/how-to-install-and-use-docker-on-ubuntu-18-04/ .

For other platforms have a look at
https://docs.docker.com/v17.12/install/ .

## 2. Download repositories and build docker container
```
git clone https://github.com/tom-doerr/commonroad-docker.git
cd commonroad-docker
docker build -t "commonroad_search"  - < commonroad_search.dockerfile
git clone https://gitlab.lrz.de/tum-cps/commonroad-search.git ../commonroad-search
cd ../commonroad-search/notebooks
```

## 3. Run the container
Run the following command to start the docker container:
```
docker run -it -p 9000:8888 --mount src="$(pwd)",target=/commonroad-search,type=bind commonroad_search
```
You can now access the jupyter notebooks by opening `localhost:9000` in your browser.


