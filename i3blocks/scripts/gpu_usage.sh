

#!/bin/bash

# Get GPU names
name1=$(nvidia-smi -q -d GPU | grep -i "Product Name" | sed -n '1p' | cut -d ':' -f2 | xargs)
name2=$(nvidia-smi -q -d GPU | grep -i "Product Name" | sed -n '2p' | cut -d ':' -f2 | xargs)

# Get memory and power usage for each GPU
memory1=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits -i 0)
memory2=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits -i 1)
power1=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits -i 0)
power2=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits -i 1)

temp1=$(nvidia-smi -q -a | grep -i "GPU Current" | grep "[0-9]*" -o | sed -n 1p)
temp2=$(nvidia-smi -q -a | grep -i "GPU Current" | grep "[0-9]*" -o | sed -n 2p)

# Extract memory usage details
mem_used1=$(echo $memory1 | cut -d ',' -f1 | xargs)
mem_total1=$(echo $memory1 | cut -d ',' -f2 | xargs)
mem_used2=$(echo $memory2 | cut -d ',' -f1 | xargs)
mem_total2=$(echo $memory2 | cut -d ',' -f2 | xargs)

# Print the results in the specified format
echo "$temp1°C Power: $power1 W Memory: ${mem_used1}W/${mem_total1}W"
echo "$temp2°C Power: $power2 W  Memory: ${mem_used2}W/${mem_total2}W"

