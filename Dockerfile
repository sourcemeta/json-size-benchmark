FROM ubuntu:21.04
WORKDIR /usr/src/app
ENV DEBIAN_FRONTEND noninteractive

# Install base dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  make \
  nodejs npm handlebars eslint \
  python3 flake8 \
  && rm -rf /var/lib/apt/lists/*

# Install format dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  lz4 lzma gzip \
  python3-avro \
  thrift-compiler python3-thrift  \
  protobuf-compiler python3-protobuf \
  python3-cbor2 \
  python3-ubjson \
  python3-msgpack \
  capnproto \
  flatbuffers-compiler \
  && rm -rf /var/lib/apt/lists/*

# Install npm dependencies
# TODO: Can we get rid of this step?
COPY package.json .
COPY package-lock.json .
RUN npm ci

# Copy benchmark source code
COPY .eslintrc.json .
COPY Makefile .
COPY benchmark ./benchmark/
COPY compression ./compression/
COPY formats ./formats/
COPY scripts ./scripts/
COPY web ./web/

# Execute the benchmark
CMD make lint html
