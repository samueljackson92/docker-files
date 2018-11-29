FROM ubuntu:latest

RUN apt update
RUN apt-get install -y clang cmake wget git libgtest-dev

RUN cd /usr/src/gtest \
        && cmake CMakeLists.txt \
        && make \
        && cp *.a /usr/lib 
 
# copy or symlink libgtest.a and libgtest_main.a to your /usr/lib folder
RUN mkdir /builds && cd builds                                                  \
        && wget https://www.openmesh.org/media/Releases/7.1/OpenMesh-7.1.tar.gz \ 
        && tar -xzf OpenMesh-7.1.tar.gz                                         \
        && rm OpenMesh-7.1.tar.gz

# Install OpenMesh
RUN cd /builds/OpenMesh-7.1 \
        && mkdir build && cd build \
        && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CC_COMPILER=clang \
        && make -j8 \ 
        && make install

# Install Google Test / Google Benchmark
RUN cd /builds \
        && git clone https://github.com/google/benchmark.git \
        && git clone https://github.com/google/googletest.git benchmark/googletest \
        && mkdir build && cd build \
        && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CC_COMPILER=clang ../benchmark \
        && make \
        && make install

RUN mkdir mesh-proto && cd mesh-proto \ 
    && mkdir src && mkdir build


VOLUME ["/mesh-proto/src", "mesh-proto/build"]
