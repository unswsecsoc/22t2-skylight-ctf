#include "sha1.h"
#include "hasher.h"
#include <linux/slab.h>
#include "md5.h"


void sha1_encode(struct hash_ctx * ctx, unsigned char in[], unsigned char out[]) {

	char *  padded_in = sha1_pad(in,&ctx->msg_len);

	unsigned int data[80];
	unsigned int rounds = ctx->msg_len / 64;

	for ( int i = 0 ; i < rounds ; i++) {

		memset(data, 0x00, 320); // 0 out data-  initializes extra words
		memcpy(data, padded_in + 64*i, 64);
		for(int j = 0 ; j < 16 ; j++) {
			data[j] = endian_swap(data[j]);
		}

		//need two copys on initialization vectors
		unsigned int local_state[5];
		memcpy(local_state, &ctx->state, 20);

		//initialize padded data
		sha1_initialize(data);	

		
		//64 compression rounds
		for (int j = 0 ; j < 80 ; j++) {
			sha1_compress(data, ctx, j);
			
		}

		//update initial vectors
		for ( int i = 0 ; i < 5 ; i++) {
			ctx->state[i] += local_state[i];
		}
		
	}

	

	memcpy(out, &ctx->state, 20);


	//reset intiailization vectors
	ctx->state[0] = 0x67452301,
	ctx->state[1] = 0xEFCDAB89,
	ctx->state[2] = 0x98BADCFE,
	ctx->state[3] = 0x10325476,
	ctx->state[4] = 0xc3d2e1f0,

	kfree(padded_in);

}

void sha1_info(struct hash_ctx * ctx, unsigned char data[]) {
	
	sprintf(data, "Algorithm: %s\n", ctx->hash_algo);
	sprintf(data + strlen(data), "Initialization vectors:    %08x    %08x    %08x    %08x    %08x\n", ctx->state[0], ctx->state[1], ctx->state[2], ctx->state[3], ctx->state[4]);
	sprintf(data + strlen(data), "Constants:\n");
	sprintf(data + strlen(data), "%08x    %08x    %08x    %08x\n", ctx->constants[0], ctx->constants[1], ctx->constants[2], ctx->constants[3]);
}

void sha1_compress(unsigned int data[], struct hash_ctx * ctx, unsigned int round) {
	unsigned int tmp;
	switch(round / 20) {
		case 0:
			tmp = R1(ctx->state[0],	ctx->state[1],ctx->state[2],ctx->state[3], ctx->state[4],  ctx->constants[0], data[round]);
			break;
		case 1:
			tmp = R2(ctx->state[0],	ctx->state[1],ctx->state[2],ctx->state[3], ctx->state[4],  ctx->constants[1], data[round]);
			break;
		case 2:
			tmp = R3(ctx->state[0],	ctx->state[1],ctx->state[2],ctx->state[3], ctx->state[4],  ctx->constants[2], data[round]);
			break;
		case 3:
			tmp = R2(ctx->state[0],	ctx->state[1],ctx->state[2],ctx->state[3], ctx->state[4],  ctx->constants[3], data[round]);
			break;
	};

	ctx->state[4] = ctx->state[3];
	ctx->state[3] = ctx->state[2];
	ctx->state[2] = ROL(ctx->state[1], 30);
	ctx->state[1] = ctx->state[0];
	ctx->state[0] = tmp;
}

void sha1_initialize(unsigned int data[]) {
	for(int i = 16 ; i < 80 ; i++) {
		data[i] =  data[i-3] ^ data[i-8] ^ data[i-14] ^ data[i-16];
		data[i] = (data[i] << 1) | (data[i] >> 31);
	}
}

char * sha1_pad(unsigned char in[], unsigned long *  msg_len) {

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
