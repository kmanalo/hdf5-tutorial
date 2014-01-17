# Tell make to make one .out file for each .f90 file found in the current directory

all: 
	@echo run \'load-future-modules run\' first
	@echo build with \'make build\'
	@echo run with \'make run\'
	@echo clean with \'make clean\'
build: $(patsubst %.f90, %.out, $(wildcard *.f90))

# Rule how to create arbitary .out files. 
# First state what is needed for them e.g. additional headers, .f90 files in an
# include folder...  Then the command to create the .out file, probably you want
# to add further options to the g++ call.

run: Makefile
	echo %@
	@echo
%.out: %.f90 Makefile
	/usr/local/packages/hdf5/1.8.9/mvapich2-1.9rc1/pgi-12.10/bin/h5pfc $< -o $@ 
	@echo

clean:
	rm -f *.out *.h5 *.o
