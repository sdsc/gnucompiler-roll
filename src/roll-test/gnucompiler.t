#!/usr/bin/perl -w
# gnucompiler roll installation test.  Usage:
# gnucompiler.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

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

# Adapted from http://en.wikipedia.org/wiki/GNU_Multiple_Precision_Arithmetic_Library
open(OUT, ">${TESTFILE}gmp.c");
print OUT <<END;
#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>
 
int main(void) {

 mpz_t x,y, result;
 mpz_init(x); mpz_init(y); mpz_init(result);
 
 mpz_set_str(x, "7612058254738945", 10);
 mpz_set_str(y, "9263591128439081", 10);
 mpz_mul(result, x, y);

 gmp_printf("%Zd\\n", result);
 
 mpz_clear(x); mpz_clear(y); mpz_clear(result);
 return EXIT_SUCCESS;

}
END

# Adapted from http://www.mpfr.org/sample.html
open(OUT, ">${TESTFILE}mpfr.c");
print OUT <<END;
#include <stdio.h>
#include <gmp.h>
#include <mpfr.h>

int main (void) {
  unsigned int i;
  mpfr_t s, t, u;

  mpfr_init2 (t, 200);
  mpfr_set_d (t, 1.0, MPFR_RNDD);
  mpfr_init2 (s, 200);
  mpfr_set_d (s, 1.0, MPFR_RNDD);
  mpfr_init2 (u, 200);
  for (i = 1; i <= 100; i++) {
    mpfr_mul_ui (t, t, i, MPFR_RNDU);
    mpfr_set_d (u, 1.0, MPFR_RNDD);
    mpfr_div (u, u, t, MPFR_RNDD);
    mpfr_add (s, s, u, MPFR_RNDD);
  }
  printf ("Sum is ");
  mpfr_out_str (stdout, 10, 0, s, MPFR_RNDD);
  putchar ('\\n');
  mpfr_clear (s);
  mpfr_clear (t);
  mpfr_clear (u);
  return 0;
}
END


# Adapted from https://www.gnu.org/ghm/2011/paris/slides/andreas-enge-mpc.pdf
open(OUT, ">${TESTFILE}mpc.c");
print OUT <<END;
#include <stdio.h>
#include <mpc.h>
int main (void) {
  mpc_t z;
  int inex;
  mpc_init2 (z, 123);
  mpc_set_ui_ui (z, 0, 2, MPC_RNDNN);
  inex = mpc_asin (z, z, MPC_RNDNN);
  mpc_out_str (stdout, 10, 0, z, MPC_RNDNN);
  printf ("%i %i\\n", MPC_INEX_RE (inex), MPC_INEX_IM (inex));
  mpc_clear (z);
}

END

# gnucompiler-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'gnu compilers installed');
} else {
  ok(! $isInstalled, 'gnu compilers not installed');
}
SKIP: {

  skip 'gnu compilers not installed', 18 if ! $isInstalled;
  my $modulesInstalled = -f '/etc/profile.d/modules.sh';
  my $setup = 'echo > /dev/null'; # noop
  if($modulesInstalled) {
    my $moduleAvail =  `. /etc/profile.d/modules.sh; module avail 2>&1`;
    my @gnuModules = ($moduleAvail =~ m#\b(gnu/[\d\.]+)#);
    $setup = ". /etc/profile.d/modules.sh;module load $gnuModules[$#gnuModules]"
      if int(@gnuModules) > 0;
  }

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

  $output = `$setup; gcc -I /opt/gnu/gmp/include -L /opt/gnu/gmp/lib -lgmp -o ${TESTFILE}gmp ${TESTFILE}gmp.c 2>&1`;
  ok($? == 0, 'gmp package compilation');
  $output = `$setup; ./${TESTFILE}gmp`;
  ok($? == 0, 'gmp package run');
  like($output, qr/70514995317761165008628990709545/, 'gmp package output');

  $output = `$setup; gcc -I /opt/gnu/mpfr/include -I /opt/gnu/gmp/include -L /opt/gnu/mpfr/lib -L /opt/gnu/gmp/lib -lmpfr -lgmp -o ${TESTFILE}mpfr ${TESTFILE}mpfr.c 2>&1`;
  ok($? == 0, 'mpfr package compilation');
  $output = `$setup; ./${TESTFILE}mpfr`;
  ok($? == 0, 'mpfr package run');
  like($output, qr/2.7182818284590452353602874713526624977572470936999595749669131/, 'mpfr package output');

  $output = `$setup; gcc -I /opt/gnu/mpc/include -I /opt/gnu/mpfr/include -I /opt/gnu/gmp/include -L /opt/gnu/mpc/lib -L /opt/gnu/mpfr/lib -L /opt/gnu/gmp/lib -lmpc -lmpfr -lgmp -o ${TESTFILE}mpc ${TESTFILE}mpc.c 2>&1`;
  ok($? == 0, 'mpc package compilation');
  $output = `$setup; ./${TESTFILE}mpc`;
  ok($? == 0, 'mpc package run');
  like($output, qr/0 1.44363547517881034249327674027310526938/, 'mpc package output');

  skip 'modules not installed', 3 if ! $modulesInstalled;
  `/bin/ls /opt/modulefiles/compilers/gnu/[0-9.]* 2>&1`;
  ok($? == 0, 'gnu module installed');
  `/bin/ls /opt/modulefiles/compilers/gnu/.version.[0-9.]* 2>&1`;
  ok($? == 0, 'gnu version module installed');
  ok(-l '/opt/modulefiles/compilers/gnu/.version',
     'gnu version module link created');

}

`rm -fr $TESTFILE*`;
