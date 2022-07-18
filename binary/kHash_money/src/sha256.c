#include "sha256.h"
#include "hasher.h"
#include <linux/slab.h>
#include "md5.h"

void sha256_encode(struct hash_ctx * ctx, unsigned char in[], unsigned char out[]) {

	char *  padded_in = sha256_pad(in,&ctx->msg_len);

	unsigned int data[64];
	unsigned int rounds = ctx->msg_len / 64;

	for ( int i = 0 ; i < rounds ; i++) {

		memset(data, 0x00, 256); // 0 out data-  initializes extra words
		memcpy(data, padded_in + 64*i, 64);
		for(int j = 0 ; j < 16 ; j++) {
			data[j] = endian_swap(data[j]);
		}

		//need two copys on initialization vectors
		unsigned int local_state[8];
		memcpy(local_state, &ctx->state, 32);

		//initialize padded data
		sha256_initialize(data);	

		//64 compression rounds
		for (int j = 0 ; j < 64 ; j++) {
			sha256_compress(data, ctx, j);
		}

		//update initial vectors
		for ( int i = 0 ; i < 8 ; i++) {
			ctx->state[i] += local_state[i];
		}
		
	}

	memcpy(out, &ctx->state, 32);


	//reset intiailization vectors
	ctx->state[0] = 0x6a09e667;
	ctx->state[1] = 0xbb67ae85;
	ctx->state[2] = 0x3c6ef372;
	ctx->state[3] = 0xa54ff53a;
	ctx->state[4] = 0x510e527f;
	ctx->state[5] = 0x9b05688c;
	ctx->state[6] = 0x1f83d9ab;
	ctx->state[7] = 0x5be0cd19;

	kfree(padded_in);

}

void sha256_info(struct hash_ctx * ctx, unsigned char data[]) {
	
	sprintf(data, "Algorithm: %s\n", ctx->hash_algo);
	sprintf(data + strlen(data), "Initialization vectors:    %08x    %08x    %08x    %08x    %08x    %08x    %08x    %08x\n", ctx->state[0], ctx->state[1], ctx->state[2], ctx->state[3], ctx->state[4],ctx->state[5], ctx->state[6], ctx->state[7]);
	sprintf(data + strlen(data), "Constants:\n");
	for (int i = 0 ; i < 64 ; i += 4) {
		sprintf(data + strlen(data), "%08x    %08x    %08x    %08x\n", ctx->constants[i], ctx->constants[i+1], ctx->constants[i+2], ctx->constants[i+3]);
	}
}

void sha256_compress(unsigned int data[], struct hash_ctx * ctx, unsigned int round) {
	//TODO might want to rename vars
	unsigned int shift_1 = ROR(ctx->state[4], 6) ^ ROR(ctx->state[4], 11) ^ ROR(ctx->state[4], 25);
	unsigned int ch = ((ctx->state[4] & ctx->state[5]) ^ ((~ctx->state[4]) & ctx->state[6]));
	unsigned int tmp_1 = shift_1 + ch + ctx->constants[round] + data[round] + ctx->state[7]; 
	unsigned int shift_0 = ROR(ctx->state[0], 2) ^ ROR(ctx->state[0], 13) ^ ROR(ctx->state[0], 22);
	unsigned int maj = ((ctx->state[0] & ctx->state[1]) ^ (ctx->state[0] & ctx->state[2]) ^ (ctx->state[1] & ctx->state[2]));
	unsigned int tmp_2 = shift_0 + maj;

	ctx->state[7] = ctx->state[6];
	ctx->state[6] = ctx->state[5];
	ctx->state[5] = ctx->state[4];
	ctx->state[4] = ctx->state[3] + tmp_1;
	ctx->state[3] = ctx->state[2];
	ctx->state[2] = ctx->state[1];
	ctx->state[1] = ctx->state[0];
	ctx->state[0] = tmp_1 + tmp_2;
}

void sha256_initialize(unsigned int data[]) {
	for(int i = 16 ; i < 64 ; i++) {
		data[i] = S0(data[i-15]) + S1(data[i-2]) + data[i-16] + data[i-7];
	}
}

char * sha256_pad(unsigned char in[], unsigned long *  msg_len) {

	char extra_block = (((*msg_len)%64) > 55);
	unsigned long bit_len = (*msg_len)*8;
	unsigned long unpadded_len = *msg_len;
	char * padded_data = NULL;

	if (extra_block) {
		padded_data = kmalloc(*msg_len + 72, GFP_KERNEL); //72 is max number of bytes we add - a 512 bit chunk + 8 bytes to pad second last chunk


		//round down bits_len, then add two blocks 
		*msg_len = (*msg_len / 64)*64;
		*msg_len += 128;
	}
	else {
		padded_data = kmalloc(*msg_len + 64, GFP_KERNEL); // max number of bytes we pad is 64 

		//round down bits_len, then add two blocks 
		*msg_len = (*msg_len / 64)*64;
		*msg_len += 64;
	}

	memcpy(padded_data,in, unpadded_len);

	//pad one 1, and the rest 0's
	padded_data[unpadded_len++] = 0x80; //0b10000000
	for(; unpadded_len < (*msg_len)-8; unpadded_len++) {
		padded_data[unpadded_len] = 0;
	}
	//attach original message length
	for(int i = 0; i < 8; i++) {
		padded_data[unpadded_len+i] = (unsigned char)((bit_len >> (56-i*8)) & 0xff);
	}

	return padded_data;

}
