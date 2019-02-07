# Set the base image to debian based miniconda3
FROM continuumio/miniconda3:4.5.12

# File Author/Maintainer
MAINTAINER Jonas Schulte-Schrepping

# This will make apt-get install without question
ENV DEBIAN_FRONTEND noninteractive

# Update and install system libraries
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends  \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    gcc \
    mono-mcs \
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
    pandoc && \
    rm -rf /var/lib/apt/lists/*
    
# Update conda
RUN conda update -n base -c defaults conda

# Set channels
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

# Install conda packages
RUN conda install -y numpy=1.16.1 \
    	  	     scipy=1.2.0 \ 
		     cython=0.29.4 \
		     numba=0.41.0 \
		     matplotlib=3.0.2 \
		     scikit-learn=0.20.2 \
		     h5py=2.9.0 \
		     click=7.0 \
		     R=3.5.1 \
		     rpy2=2.9.4 \
		     git=2.20.1 \
		     r-devtools=2.0.1  && \
    conda install -c bioconda -y samtools=1.9

RUN \
  R -e 'chooseCRANmirror(ind=52); install.packages(c("devtools", "Rcpp","RcppEigen", "RInside", "Matrix", "optparse", "rmarkdown", "withr"))'

RUN pip install pysam==0.15.2 \
    		loompy==2.0.17 \
		velocyto==0.17.17
