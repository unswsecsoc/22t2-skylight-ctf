from Crypto.PublicKey import RSA
from Crypto.Random import get_random_bytes
from Crypto.Util.number import bytes_to_long, long_to_bytes

RSA_BIT_SIZE = 2048
# Make sure a block cant be bigger than n
BLOCK_MAX_BIT_SIZE = RSA_BIT_SIZE - 2
BLOCK_SIZE_BYTES = BLOCK_MAX_BIT_SIZE // 8


def split_into_long_blocks(msg, block_size=BLOCK_SIZE_BYTES):
    return [bytes_to_long(msg[i:min(len(msg), i+block_size)]) for i in range(0, len(msg), block_size)]


class CBCRSA:
    def __init__(self):
        rsa = RSA.generate(RSA_BIT_SIZE)
        self.e = rsa.e
        self.d = rsa.d
        self.n = rsa.n

        if self.n.bit_length() <= BLOCK_MAX_BIT_SIZE:
            raise RuntimeError("Value of n generated too small")

    def rsa_enc(self, msg):
        if msg > self.n:
            raise RuntimeError("Message is too big")

        return pow(msg, self.d, self.n)

    def rsa_dec(self, msg):
        if msg > self.n:
            raise RuntimeError("Message is too big")

        return pow(msg, self.e, self.n)

    def enc(self, msg):
        while 1:
            try:
                iv = bytes_to_long(get_random_bytes(BLOCK_SIZE_BYTES))

                # Split message into BLOCK_SIZE sized blocks
                blocks = split_into_long_blocks(msg)

                prev_state = iv

                enc_blocks = []

                for b in blocks:
                    cipher_in = prev_state ^ b

                    cipher_out = self.rsa_enc(cipher_in)

                    enc_blocks.append(cipher_out)
                    prev_state = cipher_out

                return str(iv) + "|" + ",".join([str(x) for x in enc_blocks])

            # TODO
            # fix a rare edge case where the xor can cause the cipher input
            # to go above the allowed range for RSA.
            # For now just regenerate ivs until a valid message is formed.
            except:
                pass

    def dec(self, ct):
        iv, blocks = ct.split("|")
        iv = int(iv)
        blocks = [int(x) for x in blocks.split(",")]

        prev_state = iv

        dec = b""

        for b in blocks:
            cipher_out = self.rsa_dec(b)

            msg_block = prev_state ^ cipher_out
            dec += long_to_bytes(msg_block)
            prev_state = b

        return dec
