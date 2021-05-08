#!/usr/bin/env perl

use strict;
use warnings;

use Crypt::RSA;
use Crypt::RSA::Key;

sub main{

    # This program operates under the premise that you have a file containing the content of the outguessed message, called "rsa_message" in the directory you execute this from
    # It also implies that you have the Crypt::RSA module installed - check the documentation for instructions
    # In case this program returns the error "Armour Breached", remove the space and one dash (" -") in the BEGIN and the END line
    # These lines need exactly 5 dashes before the BEGIN and the END line, cicada possibly made a mistake here
    # If you like further insight into the workings of this program, write a comment please

    # It was based off of a similar source code found on a partner wiki - you guys are fantastic.

    my ($rsa, $ciphertext, $plaintext, $keych, $public, $private, $p, $q, $e, $fh);

    $rsa = new Crypt::RSA;
    $keych = new Crypt::RSA::Key;
    $p = '97513779050322159297664671238670850085661086043266591739338007321';
    $q = '77506098606928780021829964781695212837195959082370473820509360759';
    $e = '65537';

    open($fh, "<", "rsa_message") or die $!;
    $ciphertext = do { local $/; <$fh> };

    ($public, $private) = $keych->generate('p' => $p, 'q' => $q, 'e' => $e) or die $keych->errstr();
    $plaintext = $rsa->decrypt(Ciphertext => $ciphertext, Key => $private, Armour => 1) || die $rsa->errstr();
    print $plaintext;
}
