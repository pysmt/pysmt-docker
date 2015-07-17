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

# Check installation
RUN cd /pysmt; . /usr/local/lib/python2.7/dist-packages/pysmt/cmd/.smt_solvers/set_paths.sh; export; pysmt-install --check
