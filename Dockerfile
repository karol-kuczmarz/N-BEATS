FROM nvidia/cuda:11.7.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# RUN rm /etc/apt/sources.list.d/cuda.list
# RUN rm /etc/apt/sources.list.d/nvidia-ml.list

# Install system packages
RUN apt-get update  -y --fix-missing && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    wget \
    curl \
    unrar \
    unzip \
    git && \
    apt-get clean -y

    # libnvinfer6=8.0.1-1+cuda11.3.1 \
    # libnvinfer-dev=6.0.1-1+cuda11.3.1 \
    # libnvinfer-plugin6=6.0.1-1+cuda11.3.1 \

# Python
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b  && \
    rm -rf Miniconda3-latest-Linux-x86_64.sh

ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

RUN conda install -c anaconda -y \
      python=3.9 \
      pip

# JupyterLab
RUN conda install -c conda-forge jupyterlab

# Main frameworks
RUN pip install torch torchvision torchaudio

# Install requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
