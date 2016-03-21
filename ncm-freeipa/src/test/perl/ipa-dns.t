use strict;
use warnings;

use Test::Quattor;
use Test::More;

use NCM::Component::FreeIPA::Client;

my $c = NCM::Component::FreeIPA::Client->new("host.example.com");

isa_ok($c, 'NCM::Component::FreeIPA::Client', "NCM::Component::FreeIPA::Client instance returned");
isa_ok($c, 'NCM::Component::FreeIPA::DNS', "NCM::Component::FreeIPA::Client is a NCM::Component::FreeIPA::DNS instance");


done_testing();
