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
    apt-get install -y \
    python3-dev python3-pip git g++ wget make cmake \
    libprotobuf-dev protobuf-compiler \
    libopencv-dev libgoogle-glog-dev \
    libhdf5-dev libatlas-base-dev \
    software-properties-common unzip \
    build-essential libsnappy-dev \
    libleveldb-dev libhdf5-serial-dev \
    opencl-headers ocl-icd-opencl-dev \
    libviennacl-dev

# Install boost
RUN apt-get install --no-install-recommends libboost-all-dev -y

# Install required python packages
RUN pip3 install --upgrade pip && \
    pip3 install setuptools && \
    pip3 install numpy opencv-python protobuf

# Install caffe
RUN apt-get install caffe-cuda -y

# Clone openpose git repo and build
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose && \
    cd openpose/ && \
    git submodule update --init --recursive --remote && \
    mkdir build && \
    cd build && \
    cmake \
      -DCMAKE_BUILD_TYPE="Release" \
      -DBUILD_CAFFE=ON \
      -DBUILD_EXAMPLES=ON \
      -DDOWNLOAD_BODY_25_MODEL=ON \
      -DDOWNLOAD_BODY_COCO_MODEL=ON \
      -DDOWNLOAD_BODY_MPI_MODEL=ON \
      -DDOWNLOAD_HAND_MODEL=ON \
      -DBUILD_PYTHON=ON .. && \
    make all -j $(nproc)
