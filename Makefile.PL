use inc::Module::Install 0.67;
perl_version '5.008001';
  
name           'RPC-Serialized';
all_from       'lib/RPC/Serialized.pm';

requires       'Data::Serializer' => '0.41';
requires       'Exception::Class' => '1.19';
requires       'Module::MultiConf' => '0.02';
requires       'Readonly' => '1.03';
requires       'Class::Accessor::Fast::Contained' => '0.05';

recommends     'IO::Socket::SSL' => 0;
recommends     'Net::Server::PreFork' => 0;
recommends     'IO::Socket::NegKrb5' => 0;
recommends     'URI' => 0;

test_requires  'Test::More' => 0;
test_requires  'Test::Pod' => 0;
test_requires  'Test::Pod::Coverage' => 0;
test_requires  'URI' => 0;
test_requires  'IO::Socket::SSL' => 0;

WriteAll;

