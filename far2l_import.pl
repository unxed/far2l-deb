#!/usr/bin/perl

#use Data::Dumper qw(Dumper);

my $filename = shift or die "Usage: far2l_import.pl color_scheme.reg\nNeeds legacy REGEDIT4 format\n\n";
 
print "Importing " . $filename . "\n";

my @array;
open(my $fh, "<", $filename)
    or die "Failed to open file: $!\n";
while(<$fh>) { 
    chomp; 
    push @array, $_;
} 
close $fh;

# reset colors
system("rm -rf ~/.config/far2l/REG/HKU/c/k-Software/k-Far2/k-Colors");

$param = '';
foreach (@array) {

    $_ =~ s/[\x0A\x0D]//g; 

    $first = substr($_, 0, 1);
    if ($first eq 'R') {
    } elsif ($first eq '[') {

        $group = $_;
        $group = substr( $group, 1, (length($group) - 2 ) );
        my @path = split /\\/, $group;

        $path_str = "~/.config/far2l/REG/";

        foreach (@path) {
            if ($_ eq 'HKEY_CURRENT_USER') {
                $path_str_part = 'HKU/c/';
            } elsif ($_ eq 'Far') {
                $path_str_part = 'k-Far2/';
            } elsif ($_ eq 'far2') {
                $path_str_part = 'k-Far2/';
            } else {
                $path_str_part = 'k-' . $_ . '/';
            }

            $path_str .= $path_str_part;

            system("mkdir -p " . $path_str);
        }

    } elsif ($first eq '"') {
        my @parts = split /=/, $_;

        $param = $parts[0];
        $param =~ s/"(.*?)"/$1/s;

        $val = $parts[1];
        $first2 = substr($val, 0, 1);

        if ($first2 eq '"') {
            $val = substr( $val, 1, (length($val) - 2) );

            open(FH, '>', $path_str . '/v-' . $param) or die $!;
            print FH $param . "\n";
            print FH "SZ\n";
            print FH $val . '\0' . "\n";
            close(FH);
        } else {
            my ($type, $value) = split /:/, $val;
            if ($type eq 'dword') {
                open(FH, '>', $path_str . '/v-' . $param) or die $!;
                print FH $param . "\n";
                print FH "DWORD\n";
                print FH $value . "\n";
                close(FH);
            } elsif ($type eq 'hex') {
                $continues = (substr($value, -1) eq '\'');
                $value =~ tr/,/ /;
                $value =~ tr/\\/ /;
                open(FH, '>', $path_str . '/v-' . $param) or die $!;
                print FH $param . "\n";
                print FH "BINARY\n";
                $value =~ s/^\s+|\s+$//g;
                print FH $value;
                if (!$continues) { print FH "\n"; }
                close(FH);
            }
        }
    } elsif ($first eq ' ') {
        # hex, continued
        $value = $_;
        $continues = (substr($value, -1) eq '\'');
        $value =~ tr/,/ /;
        $value =~ tr/\\/ /;
        open(FH, '>>', $path_str . '/v-' . $param) or die $!;
        $value =~ s/^\s+|\s+$//g;
        print FH $value;
        if (!$continues) { print FH "\n"; }
        close(FH);
    }
}

