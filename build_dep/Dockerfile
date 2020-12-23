FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive TZ=America/New_York

# Add labels
LABEL author="Jason C. Nucciarone" \
    maintainer="Jason C. Nucciarone" \
    owner="Jason C. Nucciarone" \
    version="v1.0" \
    contributors="Andrew Polaskey, Daniel Albohn"

# Setup timezone
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

# Install my essentials
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    python3-dev python3-pip git g++ wget make cmake \
    libprotobuf-dev protobuf-compiler \
    libopencv-dev libgoogle-glog-dev \
    libboost-all-dev \
    libhdf5-dev libatlas-base-dev \
    software-properties-common unzip \
    build-essential libsnappy-dev \
    libleveldb-dev libhdf5-serial-dev \
    opencl-headers ocl-icd-opencl-dev \
    libviennacl-dev gfortran curl

# Install required python packages
RUN pip3 install --upgrade pip && \
    pip3 install setuptools && \
    pip3 install numpy opencv-python protobuf

# Install spack
RUN git clone https://github.com/spack/spack.git &&\
    mv spack /usr/local

# Add spack to path
ENV PATH=/usr/local/spack/bin:${PATH}

# Install Caffe
RUN spack compiler find && \
    spack install caffe
