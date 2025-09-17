FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    unzip \
    git \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libxt-dev \
    default-jre \
    python3 \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

# ----------------------------
# Install FastQC v0.11.8
# ----------------------------
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip && \
    unzip fastqc_v0.11.8.zip && \
    chmod +x FastQC/fastqc && \
    mv FastQC /opt/fastqc && \
    ln -s /opt/fastqc/fastqc /usr/local/bin/fastqc && \
    rm fastqc_v0.11.8.zip

# ----------------------------
# Install STAR v2.5.3a
# ----------------------------
RUN wget https://github.com/alexdobin/STAR/archive/2.5.3a.tar.gz && \
    tar -xvzf 2.5.3a.tar.gz && \
    cd STAR-2.5.3a/source && \
    make STAR && \
    cp STAR /usr/local/bin && \
    cd ../../ && rm -rf STAR-2.5.3a*

# ----------------------------
# Install RSEM v1.3.0
# ----------------------------
RUN git clone https://github.com/deweylab/RSEM.git && \
    cd RSEM && \
    git checkout v1.3.0 && \
    make && \
    cp rsem* /usr/local/bin && \
    cd .. && rm -rf RSEM

# Set default working directory and command
WORKDIR /data
CMD ["/bin/bash"]
