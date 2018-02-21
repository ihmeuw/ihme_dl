FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libcairo2-dev \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        libssl1.0.2 \
        pkg-config \
        libnlopt-dev \
        python3 \
        python3-dev \
        python3-setuptools \
        python3-pip \
        libssl-dev \
        rsync \
        netbase \
        software-properties-common \
        unzip \
	    vim \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir tensorflow==1.0.0 pandas scipy scikit-learn keras flask tqdm h5py Pillow

#IPython Port
EXPOSE 8888

ADD . stgpr_vetting/

# Make symlink for folders in /home (Singularity doesn't bind on /home contents because /home already exists from RStudio's side)
RUN ln -s /snfs1 /home/j
 
# Add UGE dev and prod to PATH (to use qstat, qsub, etc.)
ENV PATH="/usr/local/UGE/bin/lx-amd64:${PATH}"
ENV SGE_ROOT="/usr/local/UGE"
ENV DRMAA_LIBRARY_PATH="/usr/local/UGE/lib/lx-amd64/libdrmaa.so.1.0"
