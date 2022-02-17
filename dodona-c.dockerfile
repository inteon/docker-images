FROM python:3.10.2-slim-bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                       jshon=20131010-3+b1 \
                       libgtest-dev=1.8.1-3 \ 
                       g++=4:8.3.0-1 \
                       make=4.2.1-1.2 \
                       cmake=3.13.4-1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod 711 /mnt && \
    useradd -m runner

WORKDIR /usr/src/gtest

RUN cmake CMakeLists.txt && \
    make && \
    cp -- *.a /usr/lib && \
    mkdir /usr/local/lib/gtest && \
    ln -s /usr/lib/libgtest.a /usr/local/lib/gtest && \
    ln -s /usr/lib/libgtest_main.a /usr/local/lib/gtest
    
# As the runner user
USER runner
RUN mkdir /home/runner/workdir
WORKDIR /home/runner/workdir

COPY main.sh /main.sh
