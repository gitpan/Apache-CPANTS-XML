use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Apache::CPANTS::XML',
    'VERSION_FROM'	=> 'lib/Apache/CPANTS/XML.pm', # finds $VERSION
    'PREREQ_PM'		=> {
    	'XML::Simple' => 2.05,
    	'Test::More'  => 0,
    	'Apache'      => 0,
    },
);
