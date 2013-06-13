#!/usr/bin/perl -w
# gnucompiler roll installation test.  Usage:
# gnucompiler.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

# TODO figure programmatically
my $VERSION = '4.8.1';

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/gnu';
my $output;

my $TESTFILE = 'tmpgnu';

open(OUT, ">$TESTFILE.c");
print OUT <<END;
#include <stdio.h>
int main(char **args) {
  printf("Hello world\\n");
  return 0;
}
END
open(OUT, ">$TESTFILE.f");
print OUT <<END;
      PROGRAM HELLO
      PRINT*, 'Hello world!'
      END
END
close(OUT);

# gnucompiler-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'gnu compilers installed');
} else {
  ok(! $isInstalled, 'gnu compilers not installed');
}
SKIP: {

  skip 'gnu compilers not installed', 9 if ! $isInstalled;
  my $modulesInstalled = -f '/etc/profile.d/modules.sh';
  my $setup = $modulesInstalled ?
              ". /etc/profile.d/modules.sh; module load gnu/$VERSION" :
              'echo > /dev/null'; # noop

  $output = `$setup; gcc -o $TESTFILE $TESTFILE.c 2>&1`;
  ok($? == 0, 'gnu C compiler works');
  $output = `$setup; ./$TESTFILE`;
  ok($? == 0, 'compiled C program runs');
  like($output, qr/Hello world/, 'compile C program correct output');

  $output = `$setup; gfortran -o $TESTFILE $TESTFILE.f 2>&1`;
  ok($? == 0, 'gnu FORTRAN compiler works');
  $output = `$setup; ./$TESTFILE`;
  ok($? == 0, 'compiled FORTRAN program runs');
  like($output, qr/Hello world/, 'compile FORTRAN program correct output');

  skip 'modules not installed', 3 if ! $modulesInstalled;
  `/bin/ls /opt/modulefiles/compilers/gnu/[0-9.]* 2>&1`;
  ok($? == 0, 'gnu module installed');
  `/bin/ls /opt/modulefiles/compilers/gnu/.version.[0-9.]* 2>&1`;
  ok($? == 0, 'gnu version module installed');
  ok(-l '/opt/modulefiles/compilers/gnu/.version',
     'gnu version module link created');

}

`rm -fr $TESTFILE*`;
