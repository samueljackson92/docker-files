FROM jupyter/tensorflow-notebook:latest

RUN conda install --quiet --yes \
    -c conda-forge ipympl pymc3 pymongo

RUN jupyter labextension install jupyter-matplotlib
