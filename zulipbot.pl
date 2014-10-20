#!/usr/bin/env perl

use File::Slurp;
use REST::Client;
use JSON;
use Data::Dumper;
use MIME::Base64;
use Mozilla::CA;

my $stream = shift @ARGV;

my @lines = split(/\0/,read_file("LINES"));
my ($user,$key,$url) = split(/\n/,read_file("ZULIP"));

my $headers = {Accept => 'application/json',
	       Authorization => 'Basic ' . encode_base64("$user:$key",""),
	       'Content-type' => 'application/x-www-form-urlencoded'};

my $client = REST::Client->new({host => $url});

$client->POST (
    "/register",
    "event_types=[\"message\"]",
    $headers);

my $response = from_json($client->responseContent());
my ($queue_id,$last_event_id) = @$response{'queue_id','last_event_id'};

while(1) {

    $client->GET(
	"/events?queue_id=${queue_id}&last_event_id=${last_event_id}",
	$headers);

    my $responseCode = $client->responseCode();

    if ($responseCode == 200) {

	my $responseContent = from_json($client->responseContent());

	foreach my $ev (@{$$responseContent{events}}) {
	    $last_event_id = $$ev{'id'} if $$ev{'id'} > $last_event_id;
	    next unless ($$ev{type} eq "message" and
			 $$ev{message}{type} eq "stream" and
			 $$ev{message}{display_recipient} eq $stream);
	    if ($$ev{message}{content} =~ /\byow\b/i) {
		my $subject = $$ev{message}{subject};
		my $line =  $lines[int(rand($#lines+1))];
		$client->POST(
		    "/messages",
		    "type=stream&to=$stream&subject=$subject&content=$line",
		    $headers);
	    }
	}
	
    }

    sleep(1);

}




	      




