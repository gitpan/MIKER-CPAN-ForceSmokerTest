use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

use Config;
use Cwd;

open (F,'>sconfig.h') or die "could not open sconfig.h for write";
print F q|/* Written by Makefile.PL  |, scalar localtime(), q|
   Do not edit this file, edit Makefile.PL instead
 */
|;

if (defined $Config{i_unistd} && $Config{i_unistd} eq 'define') {
  print F "#define HAS_I_UNISTD\n";
}
if (defined $Config{d_getpagsz} && $Config{d_getpagsz} eq 'define') {
  print F "#define HAS_SYSCONF\n";
}
if (defined $Config{d_sysconf} && $Config{d_sysconf} eq 'define') {
  print F "#define HAS_GETPAGESIZE\n";
}

close F;

my $pwd = getcwd();

WriteMakefile(
	'NAME'	 => 'MIKER::CPAN::ForceSmokerTest',
	'VERSION_FROM' => 'ForceSmokerTest.pm', # finds $VERSION
	'dist'	 => {'COMPRESS' => 'gzip', 
		    'SUFFIX' => 'gz'},
	'clean'	 => { FILES    => "*~ tmp* sconfig.h config.log conftest.c localStuff.h"},
);

sub MY::top_targets {
   package MY;
   my $begin = q|
config :: localStuff.h
	@$(NOOP)
# siteconf CCname Cfile_ext OBJext EXEext "Cflags" "LDflags" "LDLOADLIBS"
#
localStuff.h :
	|. $pwd .q|/siteconf "$(CC)" ".c" "$(OBJ_EXT)" "$(EXE_EXT)" "$(CCFLAGS)" "$(LDFLAGS)" "$(LDLOADLIBS)"

|;
  my $inherited = shift->SUPER::top_targets(@_);
# whatever additional change, additions that may be needed
  $begin . $inherited;
}

