A Space-efficiency Benchmark of JSON-compatible Serialization Specifications
============================================================================

This is an extensible and open-source research project that aims to measure the
space-efficiency characteristics of the available JSON-compatible serialization
specifications. This work is based on the research from [A Benchmark of
JSON-compatible Binary Serialization
Specifications](https://arxiv.org/abs/2201.03051) from the same author.

***

**See Results**: https://sourcemeta.github.io/json-size-benchmark

***

Running Locally
---------------

This project makes use of [Docker](https://www.docker.com) to run the benchmark
in a reproducible environment:

```sh
# Run the benchmark
make

# Check the results at `output`
open output/index.html
```

Contributing
------------

We accept contributions that introduce new JSON-compatible serialization
specifications or that add new JSON input documents to the benchmark.

License
-------

This project is released under the terms specified in the
[license](https://github.com/sourcemeta/json-size-benchmark/blob/master/LICENSE).
