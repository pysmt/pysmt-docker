FROM ubuntu:14.04
MAINTAINER Andrea Micheli<micheli.andrea@gmail.com>, Marco Gario <marco.gario@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install pre-requisites
RUN apt-get update && \
    apt-get -y install python-setuptools python-nose python-pip python-dev make build-essential swig libgmp-dev autoconf libtool antlr3 wget curl libboost1.55-dev && \
    apt-get clean


# Add PySMT's Solvers installer
RUN pip install pysmt

# Create a folder for pysmt
RUN mkdir /pysmt

# MSAT
RUN cd /pysmt; pysmt-install --confirm-agreement --msat

# Z3
RUN cd /pysmt; pysmt-install --confirm-agreement --z3

# CVC4
RUN cd /pysmt; pysmt-install --confirm-agreement --cvc4

# YICES
RUN cd /pysmt; pysmt-install --confirm-agreement --yices

# CUDD
RUN cd /pysmt; pysmt-install --confirm-agreement --cudd

# PICOSAT
RUN cd /pysmt; pysmt-install --confirm-agreement --picosat


# Set paths
ENV PYSMT_MSAT_PATH /usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/mathsat-5.3.6-linux-x86_64/python:/usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/mathsat-5.3.6-linux-x86_64/python/build/lib.linux-x86_64-2.7
ENV PYSMT_Z3_PATH /usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/z3_bin/lib/python2.7/dist-packages
ENV PYSMT_CVC4_PATH /usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/CVC4_bin/share/pyshared:/usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/CVC4_bin/lib/pyshared
ENV PYSMT_YICES_PATH /usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/pyices-aa0b91c39aa00c19c2160e83aad822dc468ce328/build/lib.linux-x86_64-2.7
ENV PYSMT_PYCUDD_PATH /usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/repycudd-4861f4df8abc2ca205a6a09b30fdc8cfd29f6ebb
ENV PYSMT_PICOSAT_PATH /usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/picosat-960:/usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/picosat-960/build/lib.linux-x86_64-2.7

# Export PYTHONPATH globally
ENV PYTHONPATH ${PYSMT_MSAT_PATH}:${PYSMT_Z3_PATH}:${PYSMT_CVC4_PATH}:${PYSMT_YICES_PATH}:${PYSMT_PYCUDD_PATH}:${PYSMT_PICOSAT_PATH}
