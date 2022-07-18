# cbcrsa

## Authors

-   stacksparrow4

## Category

-   crypto

## Description

_AHEM_ everyone should roll their own crypto _AHEM_ it's safer that way right?

`https://cbcrsa.ctf.secso.cc/`

## Difficulty

-   Medium

## Points

90

## Hints

## Files

-   [cbcrsa.zip](./_ctfd/files/cbcrsa.zip): Source code for challenge

## Solution

<details>
<summary>Spoiler</summary>

### Idea

Exploit a badly written encrypted cookie library.

### Walkthrough

There are many problems with this library, firstly, there is no form
of authentication code or signing to check that the message hasn't been tampered
with before decoding it. Secondly, the RSA implementation does not pad the value
before decrypting it, meaning that a value of 0 or 1 will give itself after
being exponentiated. This means we can use the initialisation vector, which
is XORed with the first block, to craft a valid message.

Refer to [solve.py](./solve.py) for technical details.

### Flag

`SKYLIGHT{symm3tric_crypt0_15_34sy_2_m3ss_Up}`

</details>
