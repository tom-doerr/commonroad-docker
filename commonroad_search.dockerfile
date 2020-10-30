FROM continuumio/anaconda3

# we need to compile python modules with pybind11, 
# which only supports up to python 3.7
RUN conda create -n commonroad-py37 python=3.7
RUN echo "source activate commonroad-py37" > ~/.bashrc
RUN apt-get install \
imagemagick -y \
python3-dev -y \
make \
build-essential \
m4 \
libboost-dev \
libboost-thread-dev \
libboost-test-dev \
libboost-filesystem-dev \
cmake \
libeigen3-dev

WORKDIR /commonroad
RUN pip install commonroad-io
RUN git clone https://gitlab.lrz.de/tum-cps/commonroad-drivability-checker.git && \
cd commonroad-drivability-checker && pip install -r requirements.txt && \
bash build.sh -e "/opt/conda/envs/commonroad-py37" -v 3.7 --cgal --serializer -i -j 4
# RUN pip install triangle
ENV PYTHONPATH /commonroad-drivability-checker/
run rm /usr/bin/python3
run ln -sf python3.7 /usr/bin/python3
run bash -ic 'pip install jupyter pythoncrc'
RUN apt-get update && apt-get install -y \
socat
workdir /
ENTRYPOINT bash -c "\
source activate commonroad-py37 &&\
cd /commonroad-search/notebooks;\
socat TCP-LISTEN:8888,fork TCP:127.0.0.1:9000 &\
jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --port 9000 "
#ENTRYPOINT bash -c "source activate commonroad-py37 && jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''"

