#Tell make to make one .out file for each .f90 file found in the current directory

all: $(patsubst %.f90, %.out, $(wildcard *.f90))

#Rule how to create arbitary .out files. 
#First state what is needed for them e.g. additional headers, .cpp files in an include folder...
#Then the command to create the .out file, probably you want to add further options to the g++ call.
%.out: %.f90 Makefile
	/usr/local/packages/hdf5/1.8.9/mvapich2-1.9rc1/pgi-12.10/bin/h5pfc $< -o $@ 
	@echo

clean:
	rm -f *.out *.h5 *.o
