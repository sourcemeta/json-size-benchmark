FROM ubuntu:21.04
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  make \
  nodejs npm handlebars \
  python3 flake8 \
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

# Copy benchmark source code
COPY Makefile .
COPY package.json .
COPY package-lock.json .
COPY benchmark ./benchmark/
COPY compression ./compression/
COPY formats ./formats/
COPY scripts ./scripts/
COPY web ./web/

# Execute the benchmark
RUN make lint
CMD make html
