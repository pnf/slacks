#!env perl
use Mojolicious::Lite;
use File::Slurp;
my $token = read_file("TOKEN");
my @lines = split(/\0/,read_file("LINES"));
get '/slacks' => sub {
  my $c   = shift;
  my $t   = $c->param('token');
  if ($t eq $token) {
      $c->render(json => {text => $lines[int(rand($#lines+1))]})
  } else {
      $c->render(text => 'denied',status => 403);
   }
};
app->start;
