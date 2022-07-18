#include "base64.h"
#include <linux/string.h>
#include <linux/module.h>


MODULE_LICENSE("GPL");

void base64_encode(struct hash_ctx* ctx, unsigned char in[], unsigned char out[]) {
	int i_idx;
	int o_idx;

	int blocks_rounded = (ctx->msg_len / 3)*3;
	int rem = ctx->msg_len % 3;

	for (i_idx = 0, o_idx = 0; i_idx < blocks_rounded; i_idx += 3, o_idx += 4) {
		out[o_idx] = CHAR_SET[in[i_idx] >> 2];
		out[o_idx + 1] = CHAR_SET[((in[i_idx] & 0x3) << 4) | (in[i_idx + 1] >> 4)];
		out[o_idx + 2] = CHAR_SET[((in[i_idx + 1] & 0xf) << 2) | (in[i_idx + 2] >> 6)];
		out[o_idx + 3] = CHAR_SET[(in[i_idx + 2] & 0x3f)];
	}

	if (rem == 1) {
		out[o_idx] =  CHAR_SET[in[i_idx] >> 2];
		out[o_idx + 1] =  CHAR_SET[((in[i_idx] & 0x3) << 4)];
		out[o_idx + 2] = '=';
		out[o_idx + 3] = '='; 
		o_idx += 4;
	}
	else if (rem == 2) {
		out[o_idx] =  CHAR_SET[in[i_idx] >> 2];
		out[o_idx + 1] = CHAR_SET[((in[i_idx] & 0x3) << 4) | (in[i_idx + 1] >> 4)];
		out[o_idx + 2] = CHAR_SET[(in[i_idx + 1] & 0xf) << 2];
		out[o_idx+ 3] = '=';
		o_idx += 4;
	}

	ctx->msg_len = o_idx;

}

void base64_decode(struct hash_ctx *  ctx, unsigned char in[], unsigned char out[]) {
	int i_idx;
	int o_idx;

	if (in[ctx->msg_len - 1] == '=') {
		ctx->msg_len--;
	}
	if (in[ctx->msg_len - 1] == '=') {
		ctx->msg_len--;
	}

	int blocks_rounded = (ctx->msg_len/4)*4;
	int rem = ctx->msg_len % 4;

	for (i_idx = 0, o_idx = 0; i_idx < blocks_rounded; i_idx += 4, o_idx += 3) {
		//the input chars arent ehv alues we need to work with, but rather the indexes in CHAR_SET
		in[i_idx] = IDX(in[i_idx]);
		in[i_idx+1] = IDX(in[i_idx+1]);
		in[i_idx+2] = IDX(in[i_idx+2]);
		in[i_idx+3] = IDX(in[i_idx+3]);

		out[o_idx] = (in[i_idx] << 2) | (in[i_idx + 1] >> 4);
		out[o_idx + 1] = (in[i_idx + 1] << 4) | (in[i_idx + 2] >> 2);
		out[o_idx + 2] = (in[i_idx + 2] << 6) | (in[i_idx + 3]);
		//printk(KERN_INFO "%x %x %x", out[o_idx], out[o_idx+1], out[o_idx+2]);
		//printk(KERN_INFO "%x %x %x %x", in[i_idx], in[i_idx+1], in[i_idx+2], in[i_idx+3]);
	
	}


	if (rem == 2) {
		in[i_idx] = IDX(in[i_idx]);
		in[i_idx+1] = IDX(in[i_idx+1]);

		out[o_idx] = (in[i_idx] << 2) | (in[i_idx + 1 ] >> 4); 
	}
	else if (rem == 3) {
		in[i_idx] = IDX(in[i_idx]);
		in[i_idx+1] = IDX(in[i_idx+1]);
		in[i_idx+2] = IDX(in[i_idx+2]);

		out[o_idx] = (in[i_idx] << 2) | (in[i_idx + 1 ] >> 4); 
		out[o_idx + 1] = (in[i_idx + 1] << 4) | (in[i_idx + 2] >> 2);
	}
}

void base64_info(struct hash_ctx * ctx, unsigned char data[]) {
	sprintf(data, "Algorithm: %s\n", ctx->hash_algo);
}
