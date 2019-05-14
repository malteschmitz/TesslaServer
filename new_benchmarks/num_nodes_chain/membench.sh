#!/bin/bash

num_nodes=(8 16 24 32 48 64 96 128)
declare finished=([8]=2 [16]=15 [24]=4 [32]=23 [48]=11 [64]=29 [96]=10 [128]=91)

for i in "${num_nodes[@]}"
do
  echo -n $i
  rm -f results/memory_${i}_nodes.dat
  for k in {1..20}
  do
    echo -n "."
    /usr/bin/time -l ./tessla_server_v2 ${i}_nodes.tessla --trace traces_10000 -o ${finished[$i]}:finished 2>&1 >/dev/null | grep "maximum resident set size" | sed -E 's/ *([0-9]*).*/\1/' >> results/memory_${i}_nodes.dat
  done
  echo ""
done
