#ifdef __cplusplus
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "localStuff.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <arpa/nameser.h>
#include <arpa/nameser_compat.h>
#include <netdb.h>
#include <resolv.h>

#ifdef __cplusplus
}
#endif

/*	#define lastchanceTEST	*/

#ifdef lastchanceTEST
#ifndef NO_RESOLV_CONF
#define NO_RESOLV_CONF
#endif
#endif

struct in_addr i2p;
struct __res_state my_res_state;
struct sockaddr_in mysa;

#ifdef _PATH_RESCONF
char *path = _PATH_RESCONF;
size_t pathz = sizeof(_PATH_RESCONF);
#else
char *path = NULL;
size_t pathz = 0;
#endif

void
mysin()
{
#ifdef USELOOPBACK
	mysa.sin_addr = inet_makeaddr(IN_LOOPBACKNET, 1);
#else
	mysa.sin_addr.s_addr = INADDR_ANY;
#endif
}

unsigned int
mypgsz()
{
  return MY_PGSIZE;
}

int
lchance()
{
#ifndef NO_RESOLV_CONF
  return 0;
#else
#ifdef lastchanceTEST
  my_res_state.options = RES_INIT;
  if (res_ninit(&my_res_state) != 0)		/* punt if we can not initialize resolver interface */
    return 0;
  return my_res_state.nscount;
#else
  return get_nameservers(&my_res_state);
#endif
#endif
}

u_char *
ns_ptr(int i)
{
  i2p.s_addr = my_res_state.nsaddr_list[i].sin_addr.s_addr;
  return((u_char *)&i2p.s_addr);
}

MODULE = MIKER::CPAN::ForceSmokerTest	PACKAGE = MIKER::CPAN::ForceSmokerTest

unsigned int
myreturn0 ()
    CODE:
	RETVAL = (unsigned int)mypgsz();
    OUTPUT:
	RETVAL

void
get_default()
    PPCODE:
	mysin();
	XPUSHs(sv_2mortal(newSVpvn((u_char *)&mysa.sin_addr, NS_INADDRSZ)));
	XSRETURN(1);

void
get_path()
    PREINIT:
	SV * out;
    PPCODE:
	if (path == NULL)
	    XSRETURN_UNDEF;
	out = sv_newmortal();
	sv_setpvn(out, path, (STRLEN)pathz);    
	XPUSHs(out);

void
lastchance()
    PREINIT:
	int i, nscount;
	u_char * netptr;
    PPCODE:
	if ((nscount = lchance()) < 1) {
	    if (GIMME_V != G_ARRAY)
		XSRETURN_UNDEF;
	    else
		XSRETURN_EMPTY;
	}
	if (GIMME_V != G_ARRAY)
	    nscount = 1;

	for(i=0;i<nscount;i++) {
	    netptr = ns_ptr(i); 
	    XPUSHs(sv_2mortal(newSVpvn(netptr, NS_INADDRSZ)));
	}
	XSRETURN(nscount);
