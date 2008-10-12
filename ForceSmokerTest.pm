package MIKER::CPAN::ForceSmokerTest;

use strict;
#use diagnostics;
use vars qw($VERSION @ISA);

#require Exporter;
require DynaLoader;
use Socket;

@ISA = qw(DynaLoader);

$VERSION = '0.002';

bootstrap MIKER::CPAN::ForceSmokerTest $VERSION;

# Preloaded methods go here.

sub DESTROY () {};

# Autoload methods go after =cut, and are processed by the autosplit program.

sub get_ns {
  local *Rconf;
  my $path = get_path();
  my @ns;
  if ($path && open(Rconf,$path)) {
    my @lines = (<Rconf>);		# slurp lines
    close Rconf;
    foreach(@lines) {
      next if $_ =~ /^\s*#/;
      if ($_ =~ /nameserver\s*(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/ &&
		($_ = inet_aton($1))) {
	push @ns, $_;
      }
    }
  }
  unless (@ns || (@ns = lastchance())) {
    goto &get_default;
  }
  return wantarray ? @ns : $ns[0];
}

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
