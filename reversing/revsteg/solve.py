from struct import unpack

with open('file.bmp', 'rb') as f:
    data = f.read()

data_start = unpack('<i', data[10:14])[0]

data = data[data_start:]

result = b""
curr_byte = ""

# Remember, endianess!
key = [0x13, 0x37, 0xbe, 0xef]

for i in data:
    curr_byte = str(i & 0x1) + curr_byte
    if len(curr_byte) == 8:
        byte_num = int(curr_byte, 2)
        if byte_num == 0:
            print(result.decode())
            quit()
        result += bytes([byte_num ^ key[len(result) % 4]])
        curr_byte = ""
