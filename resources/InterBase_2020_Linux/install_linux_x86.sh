#!/bin/sh
echo Preparing InterBase installation ...

export PATH=$PATH:$TEMPDIR/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib/i386-linux-gnu
export LIBXCB_ALLOW_SLOPPY_LOCK=1

#Execute InterBase installer 
chmod +x ib_install_linux_x86.bin

# If user has asked for console mode (-i console) install, pass it along
./ib_install_linux_x86.bin $*
