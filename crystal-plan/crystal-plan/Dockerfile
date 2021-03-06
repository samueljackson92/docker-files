FROM centos:latest

ENV LANG en_US.UTF-8 

ARG gitref=master
ENV GITREF=$gitref

#Install system requirements & gcc > 4.9
RUN yum install -y git gcc gcc-c++ make cmake python-devel libpng12 gtk2 gtk2-devel gtk3-devel webkitgtk3-devel mesa-libGLU-devel gstreamer-devel gstreamer-plugins-base-devel
RUN yum install -y centos-release-scl 
RUN yum install -y devtoolset-3-gcc devtoolset-3-gcc-c++

 # Install conda with python 2
 RUN yum -y update \
         && yum -y install curl bzip2 \
         && curl -sSL https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
         && bash /tmp/miniconda.sh -bfp /usr/local/ \
         && rm -rf /tmp/miniconda.sh \
         && conda install -y python=2 \
         && conda update conda \
         && conda clean --all --yes \
         && rpm -e --nodeps bzip2 

 # Install libraries to the conda env
 # NOTE: higher versions of pyinstaller break & fail to package
 RUN /usr/bin/scl enable devtoolset-3 --                                        \
         source activate                                                        \
         && conda install -c travis wxpython                                    \
         && conda install -y -c conda-forge pybind11 xtensor xtensor-python     \
         && conda install -y -c conda-forge xtensor-blas                        \
         && conda install -y -c conda-forge numpy                               \
         && conda install -y scipy matplotlib                                   \
         && conda install -y -c conda-forge vtk                                 \
         && conda install -y Mayavi                                             \
         && conda install -y -c ivoflipse pypubsub                              \
         && pip install pyinstaller==3.1.1

RUN git clone https://github.com/samueljackson92/CrystalPlan.git                \
        && cd CrystalPlan                                                       \
        && git checkout $GITREF                                                 \
        && source activate                                                      \
        && /usr/bin/scl enable devtoolset-3 -- pip install -e .                 
        
WORKDIR /CrystalPlan

CMD /usr/bin/scl enable devtoolset-3 --                                         \
        source activate                                                         \
        && python crystalplan.py
