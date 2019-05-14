#!/bin/bash

num_events=(500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 8500 9000 9500 10000);

for i in "${num_events[@]}"
do
  echo -n $i
  rm -f results/memory_${i}.dat
  for k in {1..20}
  do
    echo -n "."
    /usr/bin/time -l ./tessla_server_v2 target_$i.tessla --trace traces_$i -o 31:finished 2>&1 >/dev/null | grep "maximum resident set size" | sed -E 's/ *([0-9]*).*/\1/' >> results/memory_${i}.dat
  done
  echo ""
done
