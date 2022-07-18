import json


def pad(m):
    padding_needed = 16 - len(m) % 16
    return m+bytes([padding_needed])*padding_needed


def unpad(ct):
    padding_needed = int(ct[-1])
    if ct[len(ct) - padding_needed:] != bytes([ct[-1]]) * padding_needed:
        raise Exception("padding invalid")
    return ct[:len(ct) - padding_needed]


def json_encode(data):
    # Start and end brackets are redundant in JSON
    return json.dumps(data)[1:-1].encode()


def json_decode(data):
    return json.loads("{" + data.decode() + "}")


WHITELIST = b'"qwertyuiopasdfghjklzxcvbnm,: '


def filter_bytes(data):
    return bytes([x for x in data if x in WHITELIST])
