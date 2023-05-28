docker run -itd --gpus all --privileged --shm-size="8g" --name shixiaozhou_esrgan -v /mnt/data:/mnt/data -v ./:/workspace  -p7108:7108  pytorch/pytorch:1.9.0 /bin/bash
