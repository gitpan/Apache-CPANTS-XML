package Apache::CPANTS::XML;
# $Id: XML.pm,v 1.4 2003/04/25 19:11:12 cwest Exp $
# -*- cperl-mode -*-
use strict;
use Apache;
use Apache::Constants qw[:response];
use vars qw[$VERSION];

use Module::CPANTS;
use XML::Simple;

$VERSION = (qw$Revision: 1.4 $)[1];

sub handler {
  my ($r) = @_;

  my $package = $r->args->{dist};
  my $data    = Module::CPANTS->data->{$package};

  return NOT_FOUND unless $data;

  $r->content_type( 'text/xml' );
  $r->send_http_header;

  my @required;
  foreach my $module ( keys %{$data->{requires_module}} ) {
    push @required, {
                     name    => $module,
                     version => $data->{requires_module}->{$module}
                    };
  }
  $data->{requires_module} = \@required;

  $data->{distribution} = $package;

  my $xml = XMLout(
                   $data,
                   KeepRoot => 1,
                   NoAttr   => 1,
                   XMLDecl  => 1,
                  );

  $r->print( $xml );

  return OK;
}

1;

__END__

=pod

=head1 NAME

Apache::CPANTS::XML - XML Web Service for CPANTS metrics

=head1 SYNOPSIS

  <Location />
    PerlModule  Apache::CPANTS::XML
    SetHandler  perl-script
    PerlHandler Apache::CPANTS::XML
  </Location>

=head1 DESCRIPTION

This module provides an XML based web service for CPANTS metrics
provided by L<Module::CPANTS|Module::CPANTS>.

=head2 Interface

  http://example.com/?dist=[dist name]

The C<[dist name]> must be a full distribution file name.

=head1 AUTHOR

Casey West <F<casey@geeknest.com>>

=head1 COPYRIGHT

  Copyright (c) 2003 Casey West <casey@geeknest.com>.  All
  rights reserved.  This program is free software; you can
  redistribute it and/or modify it under the same terms as
  Perl itself.

=head1 SEE ALSO

L<perl>,
L<Module::CPANTS>,
L<XML::Simple>,
L<Apache>.

=cut
