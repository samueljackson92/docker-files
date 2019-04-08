FROM samueljackson/data-science:latest

USER root

RUN apt-get update
RUN apt-get install -y curl m4 gfortran-4.8 libssl1.0.0 libssl-dev m4

# Set Fortran compiler
ENV FC /usr/bin/gfortran-4.8
RUN ln -sf /usr/bin/gfortran-4.8 /usr/bin/gfortran

RUN conda install -c conda-forge basemap rasterio netcdf4 netcdf-fortran pygrib
RUN pip install pydotplus graphviz
ENV PROJ_LIB=/opt/conda/share/proj

CMD start-notebook.sh
