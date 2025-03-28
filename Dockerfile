FROM ubuntu:18.04

# Installing dependencies
RUN apt update && apt install -y --no-install-recommends \
    git \
    python3 \
    python3-pip \ 
    wget  \
    libxml2-dev

# Configuring python symlinks
RUN if [ ! -e /usr/bin/python ]; then ln -s /usr/bin/python3 /usr/bin/python; fi && \
    if [ ! -e /usr/bin/pip ]; then ln -s /usr/bin/pip3 /usr/bin/pip; fi
    
# Installing the NVIDIA driver
RUN wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run

RUN chmod +x cuda_10.2.89_440.33.01_linux.run && \
    ./cuda_10.2.89_440.33.01_linux.run --silent --toolkit --override

RUN rm cuda_10.2.89_440.33.01_linux.run

RUN echo 'export PATH=/usr/local/cuda-10.2/bin${PATH:+:${PATH}}' >> ~/.bashrc && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc

# Adding the repository inside the image
ADD . ./bob_mgen

# Defining the working directory
WORKDIR /bob_mgen

# Running the installation script

RUN chmod +x /bob_mgen/conf_script.sh && \
    . ./conf_script.sh

ENTRYPOINT ["/bin/bash"]
