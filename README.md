# SDSC "gnucompiler" roll

## Overview

This roll bundles the installation of GNU compilers.

For more information about the GNU Compilers please visit the
<a href="gcc.gnu.org">official web page</a>.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).


## Dependencies

yum install glibc-devel.i686


## Building

To build the gnucompiler-roll, execute these instructions on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been
created as... `gncompiler-*.iso`. If you built the roll on a Rocks frontend then
proceed to the installation step. If you built the roll on a Rocks development
appliance you need to copy the roll to your Rocks frontend before continuing
with installation.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll gnucompiler
% cd /export/rocks/install
% rocks create distro
% rocks run roll gnucompiler | bash
```

In addition to the software itself, the roll installs gnucompiler environment
module files in:

```shell
/opt/modulefiles/compilers/gnu
```


## Testing

The gnucompiler-roll includes a test script which can be run to verify proper
installation of the gnucompiler-roll documentation, binaries and module files.
To run the test scripts execute the following command(s):

```shell
% /root/rolltests/gnucompiler.t 
```
