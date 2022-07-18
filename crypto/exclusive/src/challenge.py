# Script used to encrypt challenge file

pdf = open('unencyrpted.pdf', 'rb')

encrypted = open('challenge.pdf', 'wb')

fullDoc = pdf.read()

key = 215

for char in fullDoc:
    encrypted.write((key ^ char).to_bytes(1, byteorder='big'))

pdf.close()
encrypted.close()