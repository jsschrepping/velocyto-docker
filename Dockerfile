FROM continuumio/miniconda3:4.5.12

RUN conda update -n base -c defaults conda

RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

RUN conda install -y numpy scipy cython numba matplotlib \
scikit-learn h5py click R rpy2 git r-devtools  && \
conda install -c bioconda -y samtools


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install zlib1g-dev libbz2-dev liblzma-dev gcc mono-mcs && \
        rm -rf /var/lib/apt/lists/*

RUN apt-get update --yes && apt-get install --no-install-recommends --yes \
  build-essential \
  cmake \
  less \
  libbamtools-dev \
  libboost-dev \
  libboost-iostreams-dev \
  libboost-log-dev \
  libboost-system-dev \
  libboost-test-dev \
  libcurl4-openssl-dev \
  libssl-dev \
  libz-dev \
  nano \
  pandoc

RUN \
  R -e 'chooseCRANmirror(ind=52); install.packages(c("devtools", "Rcpp","RcppEigen", "RInside", "Matrix", "optparse", "rmarkdown", "withr"))'

RUN pip install pysam loompy

RUN pip install velocyto
