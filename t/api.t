use Test::More qw(no_plan);

use YAML::Syck qw(LoadFile);;

BEGIN { 
  use_ok('WWW::Google::API');
}

my $file_conf = LoadFile($ENV{HOME}.'/.gapi');

my $api_key  = $ENV{gapi_key}  || $file_conf->{key}  || '';
my $api_user = $ENV{gapi_user} || $file_conf->{user} || '';
my $api_pass = $ENV{gapi_pass} || $file_conf->{pass} || '';

my $api;

eval { 
  $api = WWW::Google::API->new( 'gbase',
                                 ( { auth_type => 'ProgrammaticLogin',
                                     api_key   => $api_key,
                                     api_user  => $api_user,
                                     api_pass  => $api_pass  },
                                   { } ) );
};
if ($@) {
  my $error = $@;
  warn $error;
}

isa_ok($api, 'WWW::Google::API', 'API Client');

isnt($api->token, '', 'Token is not empty');
