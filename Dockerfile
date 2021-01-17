FROM ubuntu:20.04

ENV DEBFULLNAME Chugunov Roman
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV HOME /root
ENV PATH /bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/root/.cargo/bin:/usr/src/figma-linux/.node_modules/.bin

WORKDIR /usr/src/figma-linux

RUN DEBIAN_FRONTEND=noninteractive curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt update && \
    apt install -y --no-install-recommends \
    devscripts \
    libfreetype6 \
    dput \
    build-essential \
    lsb-release \
    equivs \
    git \
    curl \
    git-buildpackage \
    nano \
    nodejs \
    npm \
    rpm \
    libfuse2 \
    libarchive-tools \
    pristine-tar && \
    cd /tmp && \
    apt-get download fuse && \
    dpkg-deb -x fuse_* . && \
    dpkg-deb -e fuse_* && \
    rm fuse_*.deb && \
    echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst && \
    dpkg-deb -b . /fuse.deb && \
    dpkg -i /fuse.deb && \
    cd /usr/src/figma-linux && \
    curl -L https://github.com/AppImage/AppImageKit/releases/latest/download/appimagetool-x86_64.AppImage --output ./appimagetool-x86_64.AppImage && \
    ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so.6 /usr/lib/libfreetype.so.6 && \
    ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so.6 /usr/lib/libfreetype.so && \
    ldconfig && \
    mv ./appimagetool-x86_64.AppImage /bin/appimagetool && \
    chmod +x /bin/appimagetool && \
    mkdir -p /root/.cargo/bin && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y