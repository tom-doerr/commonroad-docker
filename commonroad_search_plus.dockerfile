# Dockerfile containing installation steps for additional (optional) software
FROM tomdoerr/commonroad-search

RUN mkdir -p $(jupyter --data-dir)/nbextensions
RUN cd $(jupyter --data-dir)/nbextensions; git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
RUN jupyter nbextension enable vim_binding/vim_binding
