FROM continuumio/miniconda3:latest


WORKDIR /app


COPY . .


# Quantum chemistry environment
RUN conda create \
    -n qfold \
    -c psi4 \
    psi4=1.5 \
    python=3.9 \
    -y


# MCP environment
RUN conda create \
    -n mcp \
    python=3.11 \
    -y


SHELL ["conda", "run", "-n", "mcp", "/bin/bash", "-c"]


RUN pip install \
    mcp \
    amazon-braket-sdk \
    boto3 \
    numpy \
    scipy


CMD ["conda", "run", "-n", "mcp", "python", "server.py"]
