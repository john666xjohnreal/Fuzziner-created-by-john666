#!/bin/bash

# Pedir datos al usuario

echo -n "Introduce la IP o dominio del servidor objetivo: "
read TARGET

echo -n "Introduce el puerto (80/443/21/etc): "
read PORT

if [[ "$PORT" == "" ]] || [[ "$TARGET" == "" ]]; then
  echo "[ERROR] Datos incompletos."
  exit;
fi,

echo "[INFO] Iniciando fuzzing contra $TARGET:$PORT..."

# Generar payloads aleatorios cada vez que se ejecute curl...

while true; do

   # Genera un archivo temporal con datos caóticos usando Python:

   python3 ./payload_fuzzer.py > /tmp/fuzz_data.txt


    # Envía ese archivo como parte de una petición POST usando curl:

     RESPONSE=$(curl --silent --show-error --data-binary @/tmp/fuzz_data.txt http://$TARGET:$PORT)

     if [[ "$RESPONSE" == *"Internal Server Error"* ]] || \
        [[ "$RESPONSE" == *"500"* ]];
      then
         echo "[ALERT]: ¡Servidor colapsó! Datos enviados:" >> log_fuzzing.log
         cat /tmp/fuzz_data.txt | tee -a log_fuzzing.log
          break;
       fi,

done,

echo "[DONE]: Fuzzing completado."
