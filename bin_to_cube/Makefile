EXEDIR = .
EXENAME = bin_to_cube
RM = rm

.SUFFIXES:
.SUFFIXES: .F90 .o

DEBUG = FALSE

# Check for the NetCDF library and include directories 
ifeq ($(LIB_NETCDF),$(null))
#LIB_NETCDF := /usr/local/lib
LIB_NETCDF := ${EBROOTNETCDF}/lib64
endif

ifeq ($(INC_NETCDF),$(null))
#INC_NETCDF := /usr/local/include
INC_NETCDF := ${EBROOTNETCDF}/include
endif

# Determine platform 
UNAMES := $(shell uname -s)
UNAMEM := $(findstring CRAY,$(shell uname -m))


#------------------------------------------------------------------------
# Linux
#------------------------------------------------------------------------

ifeq ($(UNAMES),Linux)
ifeq ($(USER_FC),$(null))
FC := mpiifort
#FFLAGS = -c -g -r8 -fp-model source -convert big_endian -assume byterecl -ftz -traceback -O2 -assume realloc_lhs -xHost -mkl -heap-arrays -check all -fp-stack-check -I$(INC_NETCDF)
FFLAGS = -c -g -r8 -fp-model source -convert big_endian -assume byterecl -ftz -traceback -O2 -assume realloc_lhs -xHost -mkl -heap-arrays -I$(INC_NETCDF)
else
FC := $(USER_FC)
endif
LDFLAGS = -L$(LIB_NETCDF) -lnetcdf -lnetcdff

.F90.o:
	$(FC) $(FFLAGS) $<
endif
#------------------------------------------------------------------------
# Default rules and macros
#------------------------------------------------------------------------

OBJS := bin_to_cube.o shr_kind_mod.o

$(EXEDIR)/$(EXENAME): $(OBJS)
	$(FC) -o $@ $(OBJS) $(LDFLAGS)

clean:
	$(RM) -f $(OBJS)  *.mod $(EXEDIR)/$(EXENAME)

bin_to_cube.o: shr_kind_mod.o
