FROM samueljackson/data-science:latest

ARG RTTOV_SOURCE

USER root


RUN apt-get update
RUN apt-get install -y curl m4 gfortran-4.8 libssl1.0.0 libssl-dev m4

# Set Fortran compiler
ENV FC /usr/bin/gfortran-4.8
RUN ln -sf /usr/bin/gfortran-4.8 /usr/bin/gfortran

RUN conda install -c conda-forge basemap rasterio netcdf4 netcdf-fortran
ENV PROJ_LIB=/opt/conda/share/proj

# ------------------------------------------------------------------------------
# Build & Install RTTOV
# ------------------------------------------------------------------------------
USER root
# Add files to the docker container. Because you must accept the license this
# cannot be directly downloaded
COPY $RTTOV_SOURCE ./rttov.tar.gz

RUN mkdir rttov                                                                \
    && tar -xvzf rttov.tar.gz -C ./rttov

# This file preconfigures the paths for HDF5 and NetCDF. The Makefile supplied
# alongside this Dockerfile has the correct paths set.
COPY Makefile.local ./rttov/build/Makefile.local

RUN cd rttov/src                                                               \
     && ../build/Makefile.PL RTTOV_HDF=1 RTTOV_F2PY=1 RTTOV_USER_LAPACK=0      \
     && make ARCH=gfortran INSTALLDIR=/opt/conda                               

COPY mietable_noaa_amsua.dat.bz2 ./rttov/rtcoef_rttov12/mietable/mietable_noaa_amsua.dat.bz2 

RUN cd ./rttov/rtcoef_rttov12/mietable                                         \
    && bzip2 -d mietable_noaa_amsua.dat.bz2 

USER joyvan

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------
USER root

RUN rm rttov.tar.gz                                                            

USER jovyan
CMD start-notebook.sh
