# Title

## Authors

-   @stacksparrow4

## Category

-   Reversing
-   Forensics

## Description

I made my own stego program!

## Difficulty

-   Hard

## Points

100

## Files

-   (revsteg)[./_ctfd/files/revsteg]: the binary to reverse
-   (file.bmp)[./_ctfd/files/file.bmp]: image with embedded data

## Solution

<details>
<summary>Spoiler</summary>

### Idea

Reverse a custom stego program to write an extraction script.

### Walkthrough

1. Download the binary and open it in Ghidra.
1. When reading the main function and after some light reversing we have
    ```c
    key = 0xefbe3713;
    for (i = 0; (long)i < (long)msg_len; i = i + 1) {
    signed_last_bits = (uint)(i >> 0x1f) >> 0x1e;
    file_data[i] = file_data[i] ^ key[(int)((i + signed_last_bits & 3) - signed_last_bits)];
    for (j = 0; j < 8; j = j + 1) {
        img_data[j + i * 8] = img_data[j + i * 8] & 0xfe;
        img_data[j + i * 8] =
            img_data[j + i * 8] | (byte)((int)file_data[i] >> ((byte)j & 0x1f)) & 1;
    }
    }
    for (k = 0; k < 8; k = k + 1) {
        img_data[(long)k + msg_len * 8] = img_data[(long)k + msg_len * 8] & 0xfe;
    }
    out_file = fopen((char *)param_2[3],"w");
    fwrite(local_50,local_68,1,out_file);
    fclose(out_file);
    ```
    Note that the signed_last_bits variable will always be 0 as i should always
    be positive. Recalling that the + operator happens before the & operator we
    can see that the file_data line should be
    ```c
    file_data[i] ^= key[i % 4]
    ```
    as the `& 3` essentially becomes an `% 4`.
    So we are xoring our data with a key.
1. The next section of lines writes each bit of the key into the lowest bit of
   the next 8 bytes. Finally, a for loop is used to set the lowest bit of the final
   8 bytes to 0, signifying a null byte for the end of the message.
1. We can therefore write a script to reverse the encoding, making sure
   to use the same process for finding the place the message starts at. This
   gives us the flag.

    ```python
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
    ```

### Flag

`SKYLIGHT{cuST0m_5t3g0_is_a_gr3at_w4y_2_l34rn}`

</details>
