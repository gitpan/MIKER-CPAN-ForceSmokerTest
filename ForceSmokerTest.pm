package MIKER::CPAN::ForceSmokerTest;

use strict;
use vars qw($VERSION @ISA);

#require Exporter;
require DynaLoader;

@ISA = qw(DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

$VERSION = '0.001';

bootstrap MIKER::CPAN::ForceSmokerTest $VERSION;

# Preloaded methods go here.

sub DESTROY () {};

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

MIKER::CPAN::ForceSmokerTest - Stuff to run through CPAN smokers

=head1 SYNOPSIS

  use MIKER::CPAN::ForceSmokerTest.pm

  my $rv = &MIKER::CPAN::ForceSmokerTest::somefunction

=head1 DESCRIPTION

This module sole purpose is to generate test ouput from the various smokers
that automatically test newly submitted modules. It is usless in any other
respect and should not be downloaded since it will do nothing for you.

=head1 AUTHOR

  Michael Robinton <michael@bizsystems.com>

=head1 Copyright 2008 Michael Robinton

  This library is free software; you can redistribute it 
  and/or modify it under the same terms as Perl itself.

1;
