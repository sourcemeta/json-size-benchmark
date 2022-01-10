FROM ubuntu:20.04
WORKDIR /usr/src/app

# TODO: Remove all virtual python management and purely rely on Ubuntu packages

# Install dependencies
RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl build-essential cmake \
  nodejs npm \
  python3 python3-venv \
  lz4 lzma gzip \
  python3-avro python3-thrift python3-protobuf python3-cbor python3-ubjson \
  capnproto thrift-compiler protobuf-compiler flatbuffers-compiler \
  && rm -rf /var/lib/apt/lists/*

# msgpack-tools is not available on Ubuntu Packages
# TODO: Use MessagePack as a Python library instead
RUN curl -L -O https://github.com/ludocode/msgpack-tools/releases/download/v0.6/msgpack-tools-0.6.tar.gz \
  && tar fvx msgpack-tools-0.6.tar.gz \
  && cd msgpack-tools-0.6 \
  && ./configure \
  && make \
  && make install \
  && cd .. \
  && rm -rf msgpack-tools-0.6 msgpack-tools-0.6.tar.gz

# Copy benchmark source code
COPY Makefile .
COPY package.json .
COPY package-lock.json .
COPY requirements.txt .
COPY benchmark ./benchmark/
COPY compression ./compression/
COPY formats ./formats/
COPY scripts ./scripts/
COPY web ./web/

# Execute the benchmark
RUN make lint html
