#!/usr/bin/sh

if ! command -v nvidia-smi &> /dev/null; then
    echo "error:nvidia-smi not found"
    exit 1
fi

gpu_info=$(nvidia-smi --query-gpu=timestamp,name,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free,power.draw --format=csv,noheader,nounits)

if [ -z "$gpu_info" ]; then
    echo "error:no gpu information"
    exit 1
fi

timestamp=$(echo "$gpu_info" | cut -d',' -f1 | sed 's/ //g')
name=$(echo "$gpu_info" | cut -d',' -f2 | sed 's/^ //;s/ $//')
temperature=$(echo "$gpu_info" | cut -d',' -f3 | sed 's/ //g')
utilization_gpu=$(echo "$gpu_info" | cut -d',' -f4 | sed 's/ //g')
utilization_memory=$(echo "$gpu_info" | cut -d',' -f5 | sed 's/ //g')
memory_total=$(echo "$gpu_info" | cut -d',' -f6 | sed 's/ //g')
memory_used=$(echo "$gpu_info" | cut -d',' -f7 | sed 's/ //g')
memory_free=$(echo "$gpu_info" | cut -d',' -f8 | sed 's/ //g')
power_draw=$(echo "$gpu_info" | cut -d',' -f9 | sed 's/ //g')

echo "timestamp:${timestamp}"
echo "name:${name}"
echo "temperature:${temperature}°C"
echo "utilization_gpu:${utilization_gpu}%"
echo "utilization_memory:${utilization_memory}%"
echo "memory_total:${memory_total}MB"
echo "memory_used:${memory_used}MB"
echo "memory_free:${memory_free}MB"
echo "power_draw:${power_draw}W"

driver_version=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader,nounits | head -1)
echo "driver_version:${driver_version}"

