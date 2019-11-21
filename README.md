# What is it?
This repository provides a dockerfile to simplify the setup of CommonRoad-Search (https://gitlab.lrz.de/tum-cps/commonroad-search).

# Installation
## Option 1 (recommended): Use the prebuild docker image
### Install docker
On Ubuntu/Debian/Linux-Mint etc.:
```
sudo apt-get install docker.io
```

For other platforms have a look at
https://docs.docker.com/v17.12/install/ .

### Download CommonRoad-Search
```
git clone https://gitlab.lrz.de/tum-cps/commonroad-search.git
cd commonroad-search

```

### Run the docker container
```
sudo docker run -it -p 9000:8888 --mount src="$(pwd)",target=/commonroad-search,type=bind tomdoerr/commonroad-search
```

You can now access the jupyter notebooks by opening `localhost:9000` in your browser.


## Option 2: Build the docker image yourself
### Install docker
On Ubuntu/Debian/Linux-Mint etc.:
```
sudo apt-get install docker.io
```

For other platforms have a look at
https://docs.docker.com/v17.12/install/ .

### Download repositories and build docker container
```
git clone https://github.com/tom-doerr/commonroad-docker.git
cd commonroad-docker
sudo docker build -t "commonroad_search"  - < commonroad_search.dockerfile
git clone https://gitlab.lrz.de/tum-cps/commonroad-search.git ../commonroad-search
cd ../commonroad-search
```

### Run the container
Run the following command to start the docker container:
```
sudo docker run -it -p 9000:8888 --mount src="$(pwd)",target=/commonroad-search,type=bind commonroad_search
```
You can now access the jupyter notebooks by opening `localhost:9000` in your browser.


