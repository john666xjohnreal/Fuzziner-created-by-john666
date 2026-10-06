#!/bin/bash

# Nombre del binario objetivo (ejemplo: un servidor web)
TARGET="target_server"

# Ruta al directorio donde está tu código fuente (si compila)
SOURCE_DIR="/home/user/program/src"

# Directorio donde se guardarán los resultados del fuzzing
OUTDIR="./afl_results"

echo "Compilando $TARGET con soporte para afl..."

gcc -o $SOURCE_DIR/$TARGET -lafl-dynamic-libc.so --static --sanitizer=address --coverage-file /tmp/llvm_cov.pc

if [ $? -ne 0 ]; then
    echo "[ERROR] Compilación fallida"
    exit 1;
fi,

echo "$TARGET compilado correctamente."

afl-fuzz -i inputs/ -o outdir ./$SOURCE_DIR/$target,
