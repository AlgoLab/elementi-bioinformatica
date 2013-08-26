#
# Makefile 
#
# $Id: Makefile,v 1.3 2007/11/27 18:33:59 sheneman Exp $
#
#
#*****************************************************************************
#
# Copyright (c) 2004,  Luke Sheneman
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions 
# are met:
# 
#  + Redistributions of source code must retain the above copyright 
#    notice, this list of conditions and the following disclaimer. 
#  + Redistributions in binary form must reproduce the above copyright 
#    notice, this list of conditions and the following disclaimer in 
#    the documentation and/or other materials provided with the 
#    distribution. 
#  + The names of its contributors may not be used to endorse or promote 
#    products derived from this software without specific prior 
#    written permission. 
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.  
#
#*****************************************************************************
#
# AUTHOR:
# 
#   Luke Sheneman
#   sheneman@cs.uidaho.edu
#
#*****************************************************************************


# Specify your compiler here
CC	= gcc
#CC	= cc


# Uncomment the following line to use the GNU getopt_long() instead
#  of the built-in getopt_long()

#OPTFLAG = -DUSE_GNU


############################# THE CFLAGS ####################################
#
# NOTE: The optimal selection of compiler flags is important.
#       Clearcut was written and developed on a Pentium 4 Linux
#       Computer.  As such, compiler optimization flags for 
#       recent versions of GCC on the Pentium 4 platform have been
#       well tested and do make a significant impact on overall 
#       performance.  
#  
#       Several alternative sets of compiler options are listed below.
#       Customize the compiler flags (CFLAGS) to match your target system.
#


######################## ALL ARCHITECTURES ##################################

# DEFAULT GCC OPTIMIZATION CONFIGURATION (ALL ARCHITECTURES)
CFLAGS = -O3 -Wall -funroll-loops -fomit-frame-pointer

# BASIC OPTIMIZATION
#CFLAGS = -O3

######################## INTEL PENTIUM OPTIMIZATIONS ########################

# PENTIUM 4 w/SSE GCC OPTIMIZATIONS.  REQUIRES GCC >= 3.2
#CFLAGS = -O3 -funroll-loops -march=pentium4 -mcpu=pentium4 -mfpmath=sse -ffast-math -momit-leaf-frame-pointer

# GENERIC i686 OPTIMIZATIONS GCC OPTIMIZATIONS
#CFLAGS = -O3 -funroll-loops -march=i686 -mcpu=i686 -fomit-frame-pointer

# GENERIC Intel C Compiler (ICC) Optimizations
#CFLAGS = -O3 -axP -xP -unroll100 -IPF_fp_fast -IPF_fltacc+ -ip

#############################################################################


######################### POWER PC OPTIMIZATIONS ############################

# MAC OS X POWER PC OPTIMIZATIONS
#CFLAGS = -O3 -funroll-loops -fomit-frame-pointer -mcpu=powerpc -mabi=altivec -mtune=powerpc -maltivec

#############################################################################


# DEBUGGING COMPILER FLAGS
#CFLAGS	= -g3 


INCDIRS = -I /usr/local/include
DEPEND  = makedepend

# *** THE LINK FLAGS ***
#LINKFLAGS = -O3
LIBS = -lm

SRCS    = clearcut.c dist.c dmat.c fasta.c cmdargs.c prng.c getopt_long.c
OBJS	= clearcut.o dist.o dmat.o fasta.o cmdargs.o prng.o getopt_long.o
HDRS    = clearcut.h dist.h dmat.h fasta.h cmdargs.h common.h dayhoff.h getopt_long.h prng.h

all: clearcut

clean:
	rm -f *.o a.out *.a clearcut

.c.o:   $(SRCS) $(HDRS)
	$(CC) -c $(INCDIRS) $(CFLAGS) $(OPTFLAG) $(DEFS) $<

clearcut: $(OBJS) $(LIBOBJS)
	 $(CC) $(LINKFLAGS) -o $@ $(OBJS) $(LIBDIRS) $(LIBS)






