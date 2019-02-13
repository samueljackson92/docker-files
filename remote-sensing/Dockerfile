FROM samueljackson/data-science:latest

USER root

# RUN wget https://www.zlib.net/zlib-1.2.11.tar.gz
# RUN wget https://github.com/live-clones/hdf5/archive/hdf5-1_10_4.tar.gz 
RUN wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.6.2.tar.gz

RUN apt-get update
RUN apt-get install -y curl

# # Build zlib
# RUN tar -xvzf zlib-1.2.11.tar.gz \
#     && cd zlib-1.2.11 \
#     && ./configure --prefix=/usr/local \
#     && make install


# # Build HDF5
# RUN tar -xvzf hdf5-1_10_4.tar.gz \
#     && cd hdf5-hdf5-1_10_4 \
#     && ./configure --prefix=/usr/local --with-zlib=/usr/local --enable-hl --enable-shared --enable-cxx  --enable-build-mode=production \
#     && make \
#     && make install

RUN apt-get install -y m4

# Build NetCDF
RUN cd ~ \
    && tar -xvzf netcdf-c-4.6.2.tar.gz \
    && cd netcdf-c-4.6.2 \
    && CPPFLAGS='-I/opt/conda/include' LDFLAGS='-L/opt/conda/lib' ./configure --prefix=/opt/conda --disable-dap --enable-shared \
    && make \
    && make install \
    && make check 
 
USER jovyan

RUN USE_SETUPCFG=0 HDF5_INCDIR=/opt/conda/include/ HDF5_LIBDIR=/opt/conda/lib/ NETCDF4_DIR=/opt/conda pip install git+https://github.com/Unidata/netcdf4-python.git

