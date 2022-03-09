#!/bin/sh

set -e

mkdir -p build_emscripten
cd build_emscripten

USE_FLAGS=(
  -s USE_FREETYPE=1
  -s USE_VORBIS=1
  -s USE_OGG=1
  -s USE_LIBJPEG=1
  -s USE_SDL=2
  -s USE_LIBPNG=1
  -s FULL_ES2=1
  -s ASYNCIFY
  -s TOTAL_MEMORY=2147418112
  -O3
)

# might need to set this
# EM_CACHE=/Users/connorclark/tools/emsdk/upstream/emscripten/cache

emcmake cmake .. \
  -D CMAKE_BUILD_TYPE=Release \
  -D ALLEGRO_SDL=ON \
  -D SHARED=OFF \
  -D WANT_MONOLITH=ON \
  -D WANT_ALLOW_SSE=OFF \
  -D WANT_DOCS=OFF \
  -D WANT_TESTS=OFF \
  -D WANT_OPENAL=OFF \
  -D ALLEGRO_WAIT_EVENT_SLEEP=ON \
  -D SDL2_INCLUDE_DIR=$EM_CACHE/sysroot/include \
  -D CMAKE_C_FLAGS="${USE_FLAGS}" \
  -D CMAKE_CXX_FLAGS="${USE_FLAGS}" \
  -D CMAKE_EXE_LINKER_FLAGS="${USE_FLAGS}" \
  -D CMAKE_EXECUTABLE_SUFFIX_CXX=".html"

# WIP: errors due to https://github.com/emscripten-core/emscripten/issues/15325
cmake --build . -t al_example
