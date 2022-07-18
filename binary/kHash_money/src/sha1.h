#include "hasher.h"

//#define ROL(X, COUNT) ((X << COUNT) | (X >> (32-COUNT)))

#define R1(A, B, C, D, E, K, M) ((ROL(A, 5)) + ((B & C ) ^ ( ~B & D)) + E + K + M)
#define R2(A, B, C, D, E, K, M) ((ROL(A, 5)) + (B ^ C ^ D) + E + K + M)
#define R3(A, B, C, D, E, K, M) ((ROL(A, 5)) + ((B & C ) ^ ( B & D) ^ (C & D)) + E + K + M)

void sha1_encode(struct hash_ctx * ctx, unsigned char in[], unsigned char out[]);
void sha1_compress(unsigned int data[], struct hash_ctx * ctx, unsigned int round);
void sha1_info(struct hash_ctx * ctx, unsigned char data[]);
char * sha1_pad(unsigned char in[], unsigned long * msg_len);

void sha1_initialize(unsigned int data[]);

static struct hash_obj SHA1_HASHER = {
	.ops = {
		.encode = sha1_encode,
		.info = sha1_info,
	},
	.ctx = {
		.hash_algo = "sha1",
		.msg_len = 0,
		.state = {
			0x67452301,
			0xEFCDAB89,
			0x98BADCFE,
			0x10325476,
			0xc3d2e1f0,
		},
		.constants = {
			0x5a827999,
			0x6ed9eba1,
			0x8f1bbcdc,
			0xca62c1d6,
		},
	},
};
