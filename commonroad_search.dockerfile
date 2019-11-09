#FROM ubuntu:bionic
FROM continuumio/anaconda3

RUN conda install jupyter
RUN conda install ipykernel
RUN pip install ipython-autotime
RUN conda install ipywidgets
RUN conda install sphinx
RUN jupyter nbextension install --py widgetsnbextension --user
RUN jupyter nbextension enable widgetsnbextension --user --py

RUN apt-get install -y \
make \
build-essential \
m4 \
libboost-dev \
libboost-thread-dev \
libboost-test-dev \
libboost-filesystem-dev \
cmake \
libeigen3-dev 

RUN pip install commonroad-io
RUN git clone https://github.com/danfis/libccd.git && \
cd libccd && \                                                                      
mkdir build && cd build && \                                                          
cmake -G "Unix Makefiles" -DENABLE_DOUBLE_PRECISION=ON -DBUILD_SHARED_LIBS=ON .. && \
make && \                                                                            
make install                                                              

RUN git clone https://github.com/eigenteam/eigen-git-mirror.git && \
 cd eigen-git-mirror

RUN git clone https://github.com/flexible-collision-library/fcl.git && \
cd fcl && \
mkdir build && cd build && \
cmake .. && \
make && \
make install 


RUN conda create -n commonroad-py37 python=3.7

RUN bash -c "source activate commonroad-py37 && \
pip install \
pybind11 \
commonroad-io \
triangle \
matplotlib \
Shapely \
polygon3 \
numpy"

RUN conda env list

RUN git clone https://gitlab.lrz.de/tum-cps/commonroad-search.git && \
cd commonroad-search/GSMP/tools/commonroad-collision-checker && \
mkdir build && \
cd build && \
cmake -DADD_PYTHON_BINDINGS=TRUE -DPATH_TO_PYTHON_ENVIRONMENT="/opt/conda/envs/commonroad-py37" -DPYTHON_VERSION="3.7" -DCMAKE_BUILD_TYPE=Release .. && \
make

RUN cd commonroad-search/GSMP/tools/commonroad-collision-checker && \
python setup.py install

ENTRYPOINT bash -c "source activate commonroad-py37 && cd commonroad-search && jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''"




