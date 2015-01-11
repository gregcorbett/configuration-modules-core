use strict;
use warnings;
use Test::More;
use Test::Quattor;
use NCM::Component::systemd;
use NCM::Component::Systemd::Systemctl qw(systemctl_show $SYSTEMCTL);

use helper;

$CAF::Object::NoAction = 1;

=pod

=head1 DESCRIPTION

Test the C<Systemctl> module for systemd.

=head2 systemctl_show

Test systemctl_show

=cut

is($SYSTEMCTL, "/usr/bin/systemctl", "SYSTEMCTL exported");

my ($res, @names);

set_output("systemctl_show_runlevel6_target_el7");

# need a logger instance (could also use CAF::Object instance)
my $cmp = NCM::Component::systemd->new('systemd');
$res = systemctl_show($cmp, 'runlevel6.target');

is(scalar keys %$res, 63, "Found 63 keys");
is($res->{Id}, 'reboot.target', "Runlevel6 is reboot.target");

# test the split in array ref
my @isarray = qw(Names Requires Wants WantedBy Before After Conflicts);
foreach my $k (keys %$res) {
    my $r = ref($res->{$k});
    if (grep {$_ eq $k} @isarray) {
        is($r, 'ARRAY', "$k is converted to array reference");
    } else {
        ok(! $r,  "$k is not a reference");
    }
}
is_deeply($res->{Names}, ["runlevel6.target", "reboot.target"], "Runlevel6 names/aliases");


done_testing();
