#!/usr/bin/env perl

use v5.10;

use strict;
use warnings;

use Test::More;

use File::Basename;
use File::Spec;
use OTRS::OPM::Installer::Utils::File;
use HTTP::Tiny;
use HTTP::Tiny::FileProtocol;

$OTRS::OPM::Installer::Utils::File::ALLOWED_SCHEME = 'file';
$OTRS::Repository::ALLOWED_SCHEME = 'file';
$OTRS::Repository::Source::ALLOWED_SCHEME = 'file';

my $repo = File::Spec->rel2abs(
    File::Spec->catdir( dirname( __FILE__ ), 'repo' ),
);

my $file = OTRS::OPM::Installer::Utils::File->new(
    repositories => [],
    package      => $repo . '/TicketOverviewHooked-5.0.6.opm',
    otrs_version => '5.0.20',
    rc_config    => {},
);

isa_ok $file, 'OTRS::OPM::Installer::Utils::File';

my $path = $file->resolve_path;
is $path, "$repo/TicketOverviewHooked-5.0.6.opm";
is -s $path, -s "$repo/TicketOverviewHooked-5.0.6.opm";

done_testing();
