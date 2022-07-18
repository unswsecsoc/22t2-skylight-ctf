#include "md5.h"
#include <linux/slab.h>


void md5_encode(struct hash_ctx * ctx, unsigned char in[], unsigned char out[]) {

	//pad message somehow
	char * padded_in = md5_pad(in ,&ctx->msg_len);

	unsigned int old_state[4];
	memcpy(old_state, &ctx->state, 32);

	//need a 512 bit view
	unsigned int cur_block[16];

	unsigned long blocks = ctx->msg_len / 64;
	for(unsigned long i = 0; i < blocks ; i++) {
		//64 bytes = 512 bits/8
		memcpy(cur_block, padded_in + 64*i , 64);

		memcpy(old_state, &ctx->state, 16);
		//old_state[0] = ctx->state[0];
		//old_state[1] = ctx->state[1];
		//old_state[2] = ctx->state[2];
		//old_state[3] = ctx->state[3];

		for (int j = 0 ; j < 64 ; j++) {
			unsigned int tmp = ctx->state[0];
			tmp += ctx->constants[j];
			switch(j/16) {
				case 0:
					tmp += F(ctx->state[1], ctx->state[2], ctx->state[3]);
					tmp += cur_block[j];
					break;
				case 1:
					tmp += G(ctx->state[1], ctx->state[2], ctx->state[3]);
					tmp += cur_block[(((j*5)+1)%16)];
					break;
				case 2:
					tmp += H(ctx->state[1], ctx->state[2], ctx->state[3]);
					tmp += cur_block[((j*3)+5)%16];
					break;
				case 3:
					tmp += I(ctx->state[1], ctx->state[2], ctx->state[3]);
					tmp += cur_block[((j*7)%16)];
					break;
			}

			tmp = ROL(tmp, ctx->rot[j]) + ctx->state[1];

			ctx->state[0] = ctx->state[3];
			ctx->state[3] = ctx->state[2];
			ctx->state[2] = ctx->state[1];
			ctx->state[1] = tmp;
		}


		ctx->state[0] += old_state[0];
		ctx->state[1] += old_state[1];
		ctx->state[2] += old_state[2];
		ctx->state[3] += old_state[3];
	}
	


	for(int i = 0; i < 4; i++) {
		ctx->state[i] = endian_swap(ctx->state[i]);
	}

	memcpy(out, &ctx->state, 32);

	//resetting initialization vectors
	ctx->state[0] = 0x67452301;
	ctx->state[1] = 0xefcdab89;
	ctx->state[2] = 0x98badcfe;
	ctx->state[3] = 0x10325476;

	kfree(padded_in);
}

//swap endianness of word
unsigned int endian_swap(unsigned int word) {
	return ((word << 24) | ((word & 0xff00) << 8) | ((word & 0xff0000) >> 8) | ((word & 0xff000000) >> 24));
}



char * md5_pad(unsigned char in[], unsigned long *  msg_len) {

	char extra_block = (((*msg_len)%64) > 55);
	unsigned long tmp = (*msg_len)*8;
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
		padded_data[unpadded_len+i] = (unsigned char)((tmp >> i*8) & 0xff);
	}

	return padded_data;

}

void md5_info(struct hash_ctx * ctx, unsigned char data[]) {
	
	sprintf(data, "Algorithm: %s\n", ctx->hash_algo);
	sprintf(data + strlen(data), "Initialization vectors:    %08x    %08x    %08x    %08x\n", ctx->state[0], ctx->state[1], ctx->state[2], ctx->state[3]);
	sprintf(data + strlen(data), "Constants:\n");
	for (int i = 0 ; i < 64 ; i += 4) {
		sprintf(data + strlen(data), "%08x    %08x    %08x    %08x\n", ctx->constants[i], ctx->constants[i+1], ctx->constants[i+2], ctx->constants[i+3]);
	}

}
