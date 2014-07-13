package Plack::Middleware::AccessLog::Color;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use parent 'Plack::Middleware::AccessLog';
use Apache::LogFormat::Compiler;

sub prepare_app {
    local $Apache::LogFormat::Compiler::char_handler{r}
        =   q{ "\\e[36m" . }
          . $Apache::LogFormat::Compiler::char_handler{r}
          . q{ . "\\e[m" }
          ;

    my $s = $Apache::LogFormat::Compiler::char_handler{s};
    local $Apache::LogFormat::Compiler::char_handler{s}
        = sprintf q{ (                                         }
                . q{     %s =~ /^2/ ? "\\e[32m" . %s . "\\e[m" }
                . q{   : %s =~ /^4/ ? "\\e[33m" . %s . "\\e[m" }
                . q{   : %s =~ /^5/ ? "\\e[31m" . %s . "\\e[m" }
                . q{   :              "\\e[35m" . %s . "\\e[m" }
                . q{ )                                         }
            , $s, $s, $s, $s, $s, $s, $s;

    my $self = shift;
    $self->SUPER::prepare_app(@_);
}


1;
__END__

=encoding utf-8

=head1 NAME

Plack::Middleware::AccessLog::Color - colorize access log

=head1 SYNOPSIS

    > plackup --no-default-middleware -e 'enable "AccessLog::Color"' app.psgi

=head1 DESCRIPTION

Plack::Middleware::AccessLog::Color colorize access log.

=begin html

<img src="https://raw.githubusercontent.com/shoichikaji/Plack-Middleware-AccessLog-Color/master/eg/terminal.png" />

=end html

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut

