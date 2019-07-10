# Definition of Build Arguments
# ------------------------------------------------------------------------------

# Image to base this container on
ARG BASE_IMAGE=python:latest

FROM ${BASE_IMAGE}

# Pip requirements file
ARG PIP_FILE=./requirements.txt

# Install NodeJS for Jupyter Lab extensions
# ------------------------------------------------------------------------------
RUN mkdir /data && mkdir /work
VOLUME ["/data", "/work"]

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs

# Install Orca for Plotly support
# ------------------------------------------------------------------------------
RUn mkdir /orca
RUN apt-get install -y wget xvfb libgtk2.0-0 libgconf-2-4 libxss1 libxtst6 libnss3 libasound2
RUN wget https://github.com/plotly/orca/releases/download/v1.2.1/orca-1.2.1-x86_64.AppImage -P /orca
RUN chmod 777 /orca/orca-1.2.1-x86_64.AppImage 

# To avoid the need for FUSE, extract the AppImage into a directory (name squashfs-root by default)
RUN cd /orca && /orca/orca-1.2.1-x86_64.AppImage --appimage-extract
RUN printf '#!/bin/bash \nxvfb-run --auto-servernum --server-args "-screen 0 640x480x24" /orca/squashfs-root/app/orca "$@"' > /usr/bin/orca
RUN chmod 777 /usr/bin/orca

RUN pip install plotly==3.10.0 jupyterlab==0.35 ipywidgets==7.4 psutil

# Install Jupyter Lab Extensions
# ------------------------------------------------------------------------------
RUN export NODE_OPTIONS=--max-old-space-size=4096 \
    && jupyter labextension install @jupyter-widgets/jupyterlab-manager@0.38 --no-build \
    && jupyter labextension install plotlywidget@0.11.0 --no-build \
    && jupyter labextension install @jupyterlab/plotly-extension@0.18.2 --no-build \
    && jupyter lab build

# Install Additional Python Requirements
# ------------------------------------------------------------------------------
COPY ${PIP_FILE} /

RUN pip3 install -r $PIP_FILE

# Setup Envrionment
# ------------------------------------------------------------------------------
ENV PYTHONPATH="$PYTHONPATH:/work"

EXPOSE 8888

VOLUME /work /data
WORKDIR /
