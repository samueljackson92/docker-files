FROM samueljackson/data-science:latest

ARG RTTOV_SOURCE

USER root


RUN apt-get update
RUN apt-get install -y curl m4 gfortran-4.8
RUN apt-get install -y m4
ENV FC /usr/bin/gfortran-4.8
RUN ln -sf /usr/bin/gfortran-4.8 /usr/bin/gfortran

# ------------------------------------------------------------------------------
# Build & Install NetCDF C Library
# ------------------------------------------------------------------------------
RUN wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-4.6.2.tar.gz
RUN tar -xvzf netcdf-c-4.6.2.tar.gz                                            \
    && cd netcdf-c-4.6.2                                                       \
    && CPPFLAGS='-I/opt/conda/include' LDFLAGS='-L/opt/conda/lib' ./configure --prefix=/opt/conda --disable-dap --enable-shared \
    && make                                                                    \
    && make check                                                              \
    && make install                                                            
 
# ------------------------------------------------------------------------------
# Build & Install NetCDF Fortran Library
# ------------------------------------------------------------------------------
RUN wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-fortran-4.4.4.tar.gz
RUN tar -xvzf netcdf-fortran-4.4.4.tar.gz                                      \
    && cd netcdf-fortran-4.4.4                                                 \
    && FC='/usr/bin/gfortran-4.8' CPPFLAGS='-I/opt/conda/include' LD_LIBRARY_PATH='/opt/conda/lib' LDFLAGS='-L/opt/conda/lib' ./configure --prefix=/opt/conda --enable-shared \
    && make                                                                    \
    && make install                                                            
 
# ------------------------------------------------------------------------------
# Build & Install RTTOV
# ------------------------------------------------------------------------------
# Add files to the docker container. Because you must accept the license this
# cannot be directly downloaded
COPY $RTTOV_SOURCE ./rttov.tar.gz

RUN mkdir rttov \
    && tar -xvzf rttov.tar.gz -C ./rttov

# This file preconfigures the paths for HDF5 and NetCDF. The Makefile supplied
# alongside this Dockerfile has the correct paths set.
COPY Makefile.local ./rttov/build/Makefile.local

RUN cd rttov/src                                                               \
     && ../build/Makefile.PL RTTOV_HDF=1 RTTOV_F2PY=1 RTTOV_USER_LAPACK=0      \
     && make ARCH=gfortran INSTALLDIR=/opt/conda

# ------------------------------------------------------------------------------
# Install NetCDF4-python
# ------------------------------------------------------------------------------
RUN apt-get install -y libssl1.0.0 libssl-dev 
USER jovyan

RUN USE_SETUPCFG=0 HDF5_INCDIR=/opt/conda/include/ HDF5_LIBDIR=/opt/conda/lib/ NETCDF4_DIR=/opt/conda pip install git+https://github.com/Unidata/netcdf4-python.git

COPY environment.txt /tmp/

USER root
RUN apt-get install -y libgeos-dev libgdal-dev python-gdal gdal-bin
USER jovyan

RUN pip install -r /tmp/environment.txt
RUN pip install download nbclean mapboxgl hydrofunctions
RUN pip install git+https://github.com/earthlab/earthpy.git@ad143d31ab4386eba93080a1803fea291d8ed684

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------
USER root


RUN rm rttov.tar.gz                                                            \
    && rm netcdf-c-4.6.2.tar.gz                                                \
    && rm -Rf netcdf-c-4.6.2                                                   \
    && rm netcdf-fortran-4.4.4.tar.gz                                          \
    && rm -Rf netcdf-fortran-4.4.4                                             

USER jovyan
