#!/bin/bash
#**********************************************************
#* File:download-install-hdf5.sh
#* 
#* Desc:Download and Install HDF5 1.8.12
#*      This relies on configure directed by
#*      http://www.pgroup.com/resources/hdf5/hdf5_2012.htm
#*      This builds hdf5 against the current module stack
#*      and dumps it into a directory ~/data/hdf5/ if the
#*      folder does not exist
#*
#* Date:Fri 17 Jan 2014 
#*
#* Author: Kevin Manalo
#* Email:  kmanalo@gmail.com

# if file does not exist
if [ ! -f hdf5-1.8.12.tar.gz ];
then
    wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.12.tar.gz
    if [ ! -d hdf5-1.8.12 ];
    then
        tar xvfz hdf5-1.8.12.tar.gz
    fi
fi

cd hdf5-1.8.12
env CC=mpicc FC=mpif90 CXX=mpicxx LDFLAGS=-lnuma ./configure --enable-fortran \
    --enable-fortran2003 --enable-production --enable-unsupported \
    --enable-parallel  \
    --enable-cxx --with-zlib --with-szlib --prefix=$HOME/data/hdf5

if [ ! -d $HOME/data/hdf5 ];
then
    echo "Directory not found, creating $HOME/data/hdf5"
    mkdir $HOME/data/hdf5
    make >& make.log
    make test >& make_test.log
    make install
else
    echo You built this before so remove $HOME/data/hdf5 to reinstall ...
fi
