BEGIN {

	# indicate for CPAN testers that we only support OS X
	unless ($^O eq "darwin") {
		die "OS unsupported\n";
	}

	# check that Keyboard Maestro is running and cowardly refuse to
	# install if it's not
	unless (`ps x` =~ /Keyboard Maestro Engine/ || $ENV{PERL_KM_FORCE}) {
		print STDERR <<'BLURB';
This module requires Keyboard Maestro to be installed.  The Keboard Maestro
Engine (the doohicky that sits in your menubar) doesn't seem to be running.

You can download a version of Keyboard Maestro (with a free trial) from:

     http://www.keyboardmaestro.com/

Giving up without creating a Makefile.  Please re-run Makefile.PL once you've
installed and started Keyboard Maestro Engine.

(If for some reason you really want to install this module without first
installing Keyboard Maestro and you don't mind the test suite of this module
failing then set the PERL_KM_FORCE environment variable to true before running
this Makefile.PL)
BLURB
		# as per http://wiki.cpantesters.org/wiki/CPANAuthorNotes
		exit 0;
	}
}

use inc::Module::Install;

name           'Mac-KeyboardMaestro';
all_from       'lib/Mac/KeyboardMaestro.pm';

requires       'Test::More'       => 0;
requires       'Mac::AppleScript' => 0.04;

license 'perl';
githubmeta;
author_tests('xt');
readme_from    'lib/Mac/KeyboardMaestro.pm';

WriteAll;
