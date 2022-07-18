#include "hasher.h"

static const unsigned char CHAR_SET [] = {"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"};

#define IDX(x) ((unsigned long)strchr(CHAR_SET, x) - (unsigned long)CHAR_SET)

void base64_encode(struct hash_ctx * ctx, unsigned char in[], unsigned char out[]);
void base64_decode(struct  hash_ctx * ctx, unsigned char in[], unsigned char out[]);
void base64_info(struct hash_ctx * ctx, unsigned char data[]);

static struct hash_obj BASE64_HASHER = {
	.ops = {
		.encode = base64_encode,
		.decode = base64_decode,
		.info = base64_info,
	},
	.ctx = {
		.msg_len = 0,
		.hash_algo = "base64",
	},
};

