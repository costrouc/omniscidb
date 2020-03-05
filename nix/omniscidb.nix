{ lib
, clangStdenv
, llvmPackages
, fetchFromGitHub
, cmake
, go
, maven
, boost
, snappy
, gflags
, glog
, double-conversion
, libarchive
, libkml
, libpng
, libiconv
, c-blosc
, gdal
, arrow-cpp
, thrift
, ncurses
, flex
, bisonpp
, openssl
, openjdk8
, xz
, bzip2
, zlib
, rdkafka
, jq
, useGPU ? false, cudatoolkit,
}:

clangStdenv.mkDerivation rec {
  pname = "omniscidb";
  version = "5.1.1";

  src = fetchFromGitHub {
    owner = "omnisci";
    repo = pname;
    rev = "v${version}";
    sha256 = "0871yfmp18i5bhcb38677y7s4flp52gk0d4i7glbx0ij63xb0gsp";
  };

  nativeBuildInputs = [
    cmake
    go
    maven
  ];

  buildInputs = [
    llvmPackages.clang-unwrapped
    llvmPackages.llvm
    boost
    snappy
    gflags
    glog
    libarchive
    libkml
    libpng
    libiconv
    double-conversion
    c-blosc
    gdal
    arrow-cpp
    thrift
    ncurses
    flex
    bisonpp
    openssl
    openjdk8
    xz
    bzip2
    zlib
    rdkafka
    jq
  ] ++ lib.optionals useGPU [ cudatoolkit ];

  cmakeFlags = [
    "-DMAPD_DOCS_DOWNLOAD=off"
    "-DENABLE_AWS_S3=off"
    "-DENABLE_CUDA=off"
    "-DENABLE_FOLLY=off"
    "-DENABLE_JAVA_REMOTE_DEBUG=off"
    "-DENABLE_PROFILER=off"
    "-DENABLE_TESTS=on"
    "-DPREFER_STATIC_LIBS=off"
    "-DCMAKE_C_COMPILER=clang"
    "-DCMAKE_CXX_COMPILER=clang++"
  ];

  makeFlags = [ "omnisci_server" ];
}
