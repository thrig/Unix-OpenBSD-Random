#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <stdlib.h>

typedef SV * Unix_OpenBSD_Random;

MODULE = Unix::OpenBSD::Random		PACKAGE = Unix::OpenBSD::Random		

PROTOTYPES: ENABLE

uint32_t
arc4random()

uint32_t
arc4random_uniform(upper_bound)
    uint32_t upper_bound
