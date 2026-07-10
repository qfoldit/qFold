FROM continuumio/miniconda3:latest


LABEL org.opencontainers.image.title="qFold MCP"
LABEL org.opencontainers.image.description="Quantum Protein Folding MCP Server"
LABEL org.opencontainers.image.source="https://github.com/qfoldit/qFold-MCP"


WORKDIR /app


RUN apt-get update && apt-get install -y \
    libxrender1 \
    libxext6 \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*


COPY . /app


RUN conda create \
    -n qfold \
    -c psi4 \
    psi4=1.5 \
    python=3.9 \
    -y


SHELL ["conda", "run", "-n", "qfold", "/bin/bash", "-c"]


RUN pip install \
    mcp \
    amazon-braket-sdk \
    boto3 \
    numpy \
    scipy \
    torch


CMD [
 "conda",
 "run",
 "-n",
 "qfold",
 "python",
 "server.py"
]
