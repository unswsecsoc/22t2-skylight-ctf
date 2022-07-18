#define HASH_INIT 0xdead0000
#define HASH_ENCODE 0xdead0001
#define HASH_DECODE 0xdead0002
#define HASH_INFO 0xdead0003

#define HASH_BASE64 0xdead1000
#define HASH_MD5 0xdead1001
#define HASH_SHA256 0xdead1002
#define HASH_SHA1 0xdead1003

#define HASH_UNDEFINED 0xdead2000

#ifndef HASHER_H
#define HASHER_H
struct hash_ctx {
	unsigned long msg_len;
	char hash_algo[7];
	unsigned int state[8];
	unsigned int constants[64];
	unsigned char rot[64];
};

struct hash_ops {
	void (*encode) (struct hash_ctx *, unsigned char[], unsigned char[]);
	void (*decode) (struct hash_ctx *, unsigned char[], unsigned char[]);
	void (*info) (struct hash_ctx *, unsigned char[]);
};

struct hash_obj {
	struct hash_ctx ctx;
	struct hash_ops ops;
};

struct user_req {
	unsigned long len;
	char * in;
	char * out;
};
#endif
