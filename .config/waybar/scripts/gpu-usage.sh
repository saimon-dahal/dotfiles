#!/bin/bash

# Detect how many GPUs are present
gpu_count=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)

# Get usage of GPU 0
usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits -i 0 | xargs)

# Build tooltip content
tooltip=""
for ((i=0; i<gpu_count; i++)); do
  temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits -i $i | xargs)
  power=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits -i $i | xargs)
  memory=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits -i $i)
  mem_used=$(echo $memory | cut -d ',' -f1 | xargs)
  mem_total=$(echo $memory | cut -d ',' -f2 | xargs)

  tooltip+="GPU $i: ${temp}°C  Power: ${power}W  Memory: ${mem_used}MiB/${mem_total}MiB\n"
done

# Escape newlines and wrap tooltip and usage in JSON
escaped_tooltip=$(echo -e "$tooltip" | jq -Rs .)

# Output valid JSON
echo "{\"text\": \"$usage%\", \"tooltip\": $escaped_tooltip}"
