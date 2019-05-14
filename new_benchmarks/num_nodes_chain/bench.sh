#!/bin/bash

num_nodes=(8 16 24 32 48 64 96 128)
declare finished=([8]=2 [16]=15 [24]=4 [32]=23 [48]=11 [64]=29 [96]=10 [128]=91)

for i in "${num_nodes[@]}"
do
  echo $i
  dumbbench --table=time_${i}_nodes.dat -p 0.0001 -m 20 -- bash -c "./tessla_server_v2 ${i}_nodes.tessla --trace traces_10000 -o ${finished[$i]}:finished > /dev/null"
done