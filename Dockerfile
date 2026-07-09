FROM continuumio/miniconda3:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libxrender1 \
    libxext6 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN conda create -n qfold -c psi4 psi4=1.5 python=3.6 -y

SHELL ["conda", "run", "-n", "qfold", "/bin/bash", "-c"]

RUN pip install --upgrade pip==21.3.1 && \
    pip install \
    numpy==1.19.5 \
    scipy==1.5.4 \
    tensorflow==2.6.2 \
    keras==2.6.0 \
    matplotlib==3.3.4 \
    bokeh==2.3.3 \
    functools32==3.2.3-2 \
    progressbar==2.5 \
    qiskit==0.29.0 \
    qiskit-aer==0.8.2 \
    qiskit-aqua==0.9.4 \
    qiskit-ibmq-provider==0.16.0 \
    qiskit-ignis==0.6.0 \
    qiskit-terra==0.18.1

RUN sed -i 's|"psi4_path": ".*"|"psi4_path": "/opt/conda/envs/qfold/bin/psi4"|g' config/config.json

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "qfold", "python", "main.py"]
