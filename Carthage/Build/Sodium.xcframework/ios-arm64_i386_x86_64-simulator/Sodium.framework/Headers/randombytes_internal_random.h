
#ifndef randombytes_internal_random_H
#define randombytes_internal_random_H

#include <Sodium/export.h>
#include <Sodium/randombytes.h>

#ifdef __cplusplus
extern "C" {
#endif

SODIUM_EXPORT
extern struct randombytes_implementation randombytes_internal_implementation;

/* Backwards compatibility with libsodium < 1.0.18 */
#define randombytes_salsa20_implementation randombytes_internal_implementation

#ifdef __cplusplus
}
#endif

#endif
