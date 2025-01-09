FROM espressif/idf:v5.1.2

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -qq update && \
    apt-get -qq install \
    git \
    libusb-1.0-0 \
    nano \
    python-is-python3 \
    python3 \
    python3-num2words \
    python3-pip \
    python3-requests \
    python3-venv \
    sudo \
    tio \
    && rm -rf /var/lib/apt/lists/*

# Podman
RUN useradd --create-home --uid 1000 build
COPY --chown=1000 container.gitconfig /home/build/.gitconfig

# Docker
COPY container.gitconfig /root/.gitconfig

ENV PATH="$PATH:/willow/.local/bin"
WORKDIR /willow

# TODO tag before merging to main
ENV ADF_VER="faddb6f693916c47205ad00825b314e95ca7831e"
RUN \
    cd /opt/esp/idf && \
    curl https://raw.githubusercontent.com/toverainc/esp-adf/$ADF_VER/idf_patches/idf_v5.1_freertos.patch | patch -p1
