use 5.008004;
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
    NAME              => 'RPC::Serialized',
    VERSION_FROM      => 'lib/RPC/Serialized.pm', # finds $VERSION
    PREREQ_PM         => {
        Data::Serializer  => '0.41',
        Exception::Class  => '1.19',
        Module::MultiConf => '0.02',
        Readonly          => '1.03',
        Class::Accessor::Fast::Contained => '0.05',
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT       => 'Perl modules for building RPC client/server applications',
       AUTHOR         => 'Oliver Gorwits <oliver.gorwits@oucs.ox.ac.uk>') : ()),
);
