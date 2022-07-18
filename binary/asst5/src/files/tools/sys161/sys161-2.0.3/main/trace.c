#include <stdarg.h>
#include <string.h>
#include "config.h"

#include "console.h"
#include "trace.h"


#ifdef USE_TRACE

static const struct {
	int ch;
	int flag;
	const char *name;
} flaginfo[] = {
	/* Note: not necessarily in same order as DOTRACE flags */
	{ 'k', DOTRACE_KINSN, "kinsn" },
	{ 'u', DOTRACE_UINSN, "uinsn" },
	{ 'j', DOTRACE_JUMP,  "jump" },
	{ 't', DOTRACE_TLB,   "tlb" },
	{ 'x', DOTRACE_EXN,   "exn" },
	{ 'i', DOTRACE_IRQ,   "irq" },
	{ 'd', DOTRACE_DISK,  "disk" },
	{ 'n', DOTRACE_NET,   "net" },
	{ 'e', DOTRACE_EMUFS, "emufs" },
	{ -1, -1, NULL }
};

int g_traceflags[NDOTRACES];

static
int
set_traceflag(int ch)
{
	int j, f;

	for (j=0; flaginfo[j].ch >= 0; j++) {
		if (flaginfo[j].ch == ch) {
			f = flaginfo[j].flag;
			g_traceflags[f] = !g_traceflags[f];
			return 0;
		}
	}
	return -1;
}

int
adjust_traceflag(int letter, int onoff)
{
	int j, f;
	for (j=0; flaginfo[j].ch >= 0; j++) {
		if (flaginfo[j].ch == letter) {
			f = flaginfo[j].flag;
			g_traceflags[f] = onoff;
			return 0;
		}
	}
	return -1;
}

void
set_traceflags(const char *letters)
{
	int i;

	for (i=0; letters[i]; i++) {
		if (set_traceflag(letters[i])) {
			msg("Unknown trace flag %c", letters[i]);
			die();
		}
	}
}

void
print_traceflags(void)
{
	int i, k=0;
	for (i=0; i<NDOTRACES; i++) {
		if (g_traceflags[i]) k++;
	}

	if (k==0) {
		return;
	}

	msgl("Tracing enabled:");
	for (i=0; i<NDOTRACES; i++) {
		if (g_traceflags[i]) {
			msgl(" %s", flaginfo[i].name);
		}
	}
	msg(" ");
}

#endif /* USE_TRACE */
