import requests
from Crypto.Util.number import bytes_to_long

TARGET = "http://127.0.0.1:3000/flag"


# copied from cbcrsa.py
RSA_BIT_SIZE = 2048
# Make sure a block cant be bigger than n
BLOCK_MAX_BIT_SIZE = RSA_BIT_SIZE - 2
BLOCK_SIZE_BYTES = BLOCK_MAX_BIT_SIZE // 8

desired_cookie = b'{"is_admin":true}'
payload = str(bytes_to_long(desired_cookie) ^ 1) + "|1"

print(requests.get(TARGET, cookies={"auth": payload}).text)
