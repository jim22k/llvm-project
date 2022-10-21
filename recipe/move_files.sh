#!/bin/bash
set -x -e

mkdir -p $SP_DIR
mv $SRC_DIR/files-to-keep/mlir $SP_DIR/

rm $PREFIX/bin/llvm-*
rm $PREFIX/bin/mlir-*
rm $PREFIX/lib/libLLVM*
rm $PREFIX/lib/libMLIR*
