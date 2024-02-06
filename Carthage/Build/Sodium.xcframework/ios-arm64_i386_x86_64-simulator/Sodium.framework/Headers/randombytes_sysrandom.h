
#ifndef randombytes_sysrandom_H
#define randombytes_sysrandom_H

#include <Sodium/export.h>
#include <Sodium/randombytes.h>

#ifdef __cplusplus
extern "C" {
#endif

SODIUM_EXPORT
extern struct randombytes_implementation randombytes_sysrandom_implementation;

#ifdef __cplusplus
}
#endif

#endif
