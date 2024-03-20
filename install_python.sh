#!/usr/bin/env bash

set -x
set -e

PYTHON_VERSION=${1}

CONDA_DIR="/opt/conda"
CONDA_INSTALLER="Miniconda3-py39_23.5.2-0-Linux-x86_64.sh"
CONDA_SHA256="9829d95f639bd0053b2ed06d1204e60644617bf37dd5cc57523732e0e8d64516"
CONDA_URL="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/"

mkdir -p /etc/determined/conda.d
mkdir -p "${CONDA_DIR}"

cd /tmp
curl --retry 3 -fsSL -O "${CONDA_URL}/${CONDA_INSTALLER}"
echo "${CONDA_MD5}  ${CONDA_INSTALLER}" | sha256sum -c -
bash "./${CONDA_INSTALLER}" -u -b -p "${CONDA_DIR}"
rm -f "./${CONDA_INSTALLER}"

conda install python=${PYTHON_VERSION}
conda update --prefix ${CONDA_DIR} --all -y
conda clean --all -f -y
