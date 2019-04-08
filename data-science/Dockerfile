FROM jupyter/tensorflow-notebook:latest

RUN pip uninstall -y numpy

RUN conda install -c intel --quiet --yes \
    'tensorflow=1.13*' \
    numpy==1.16.1

RUN conda install --quiet --yes \
    -c conda-forge ipympl pymc3 pymongo dash==0.34.0 dash-html-components==0.13.4 dash-core-components==0.41.0 tensorflow-probability
RUN pip install dash-table==3.1.11 pytest requests-mock
RUN jupyter labextension install jupyter-matplotlib

