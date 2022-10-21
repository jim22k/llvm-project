mkdir -p build
cd build

cmake -G Ninja $SRC_DIR/llvm \
   -DCMAKE_INSTALL_PREFIX=$PREFIX \
   -DLLVM_ENABLE_PROJECTS=mlir \
   -DLLVM_BUILD_EXAMPLES=OFF \
   -DLLVM_INSTALL_UTILS=ON \
   -DLLVM_TARGETS_TO_BUILD="X86;AArch64;NVPTX;AMDGPU" \
   -DCMAKE_BUILD_TYPE=Release \
   -DLLVM_ENABLE_ASSERTIONS=ON \
   -DLLVM_BUILD_LLVM_DYLIB=ON \
   -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
   -DPython3_EXECUTABLE=`which python`

# temporary hack for macos
cp $PREFIX/lib/libtinfo* lib/
cp $PREFIX/lib/libz* lib/

# verify MLIR works
cmake --build . --target check-mlir || true
# build everything else
cmake --build .
cmake --install .

mkdir $SRC_DIR/files-to-keep
cp -a $PREFIX/python_packages/mlir_core/mlir $SRC_DIR/files-to-keep
