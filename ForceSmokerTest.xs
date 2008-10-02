#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "localStuff.h"
#ifdef __cplusplus
}
#endif

unsigned int
mypgsz()
{
  return MY_PGSIZE;
}

MODULE = MIKER::CPAN::ForceSmokerTest        PACKAGE = MIKER::CPAN::ForceSmokerTest

unsigned int
myreturn0 ()
    CODE:
	RETVAL = (unsigned int)mypgsz();
    OUTPUT:
	RETVAL

