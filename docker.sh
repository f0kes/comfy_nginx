docker run --name pytorch -v $(pwd):/workspace -p 8888:8888 -p 6006:6006 pytorch/pytorch:2.2.0-cuda12.1-cudnn8-devel