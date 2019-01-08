FROM jupyter/tensorflow-notebook:latest

RUN conda install --quiet --yes \
    -c conda-forge ipympl pymc3 pymongo dash==0.34.0 dash-html-components==0.13.4 dash-core-components==0.41.0 

RUN pip install dash-table==3.1.11
RUN jupyter labextension install jupyter-matplotlib
