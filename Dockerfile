FROM ubuntu:21.04
WORKDIR /usr/src/app
ENV DEBIAN_FRONTEND noninteractive

# Install base dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  make jq \
  nodejs npm handlebars eslint webpack node-chart.js \
  python3 flake8 python3-jsonpatch python3-importlib-metadata \
  clojure \
  && rm -rf /var/lib/apt/lists/*

# Install format dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  lz4 lzma gzip \
  python3-avro \
  thrift-compiler python3-thrift  \
  protobuf-compiler python3-protobuf \
  python3-bson \
  python3-cbor2 \
  python3-ubjson \
  python3-msgpack \
  libcheshire-clojure \
  capnproto \
  flatbuffers-compiler \
  && rm -rf /var/lib/apt/lists/*

# Copy benchmark source code
COPY .eslintrc.json .
COPY Makefile .
COPY benchmark ./benchmark/
COPY compression ./compression/
COPY formats ./formats/
COPY scripts ./scripts/
COPY web ./web/
COPY vendor ./vendor/

# Execute the benchmark
CMD make --jobs 8 lint html
