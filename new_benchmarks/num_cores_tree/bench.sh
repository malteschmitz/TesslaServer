#!/bin/bash

num_cores=(1 2 4 8 16);

for i in "${num_cores[@]}"
do
  echo $i
  dumbbench --table=time_${i}_cores.dat -p 0.0001 -m 20 -- bash -c "./tessla_server_$i target_10000.tessla --trace traces.1 -o 31:finished > /dev/null"
done
