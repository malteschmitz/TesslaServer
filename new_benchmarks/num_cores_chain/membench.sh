#!/bin/bash

num_cores=(1 2 4 8 16);

for i in "${num_cores[@]}"
do
  echo -n $i
  rm -f results/memory_${i}_cores.dat
  for k in {1..20}
  do
    echo -n "."
    /usr/bin/time -l ./tessla_server_$i parallel-16.tessla --trace traces.1 -o 4:finished 2>&1 >/dev/null | grep "maximum resident set size" | sed -E 's/ *([0-9]*).*/\1/' >> results/memory_${i}_cores.dat
  done
  echo ""
done
