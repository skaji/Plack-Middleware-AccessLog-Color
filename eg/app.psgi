#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Amon2::Lite;

get "/{status:[0-9]{3}}/*" => sub {
    my ($c, $argv) = @_;
    my $status = $argv->{status};
    $c->create_simple_status_page($status => "hoge");
};

__PACKAGE__->to_app;
