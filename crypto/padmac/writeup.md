# PADMAC

## Authors

-   @stacksparrow4

## Category

-   Web
-   Crypto

## Description

Well it looks like our CBCRSA implementation didn't work. Not to worry, as
our "experts" have come up with a new "secure" cookie system! There's no
way it's hackable this time, right?

`https://padmac.ctf.secso.cc/`

## Difficulty

-   Hard

## Points

120

## Files

-   [padmac.zip](./_ctfd/files/padmac.zip): challenge source

## Solution

<details>
<summary>Spoiler</summary>

🧀🧀🧀

Disclaimer: it turns out you can cheese this challenge by using a payload
like `bob\", \"admin\": true, \"me\": \"awesome` in the name field. However,
I will go through the intended solution here.
Credit to @yellowsubmarine1447 for this alternate solution

### Idea

Utilise a combination of a padding oracle and a hash length extension attack to
forge a cookie allowing you to access the flag.

### Walkthrough

1. The design is vulnerable to a hash length extension attack as the message
   authentication code (MAC) consists of hash(secret + msg). Instead, most
   HMAC implementations use hash(secret + hash(msg)) to prevent this attack.
   Due to this, if we could find a way to encrypt messages, we can make a
   valid cookie by extending the hash of the message.
2. We can encrypt and decrypt messages by exploiting a padding oracle attack.
   This attack uses the fact that the unpad command raises an exception if the
   padding is invalid. We can use the tool [padbuster](https://github.com/AonCyberLabs/PadBuster)
   to exploit this.
3. Using these two exploits together we can craft an admin cookie without knowing
   the key. This does require a few minute bruteforce from padbuster. Refer
   to [solve.py](./solve.py) for the implementation details.

### Flag

`SKYLIGHT{sT0p_h4cking_d4_MAC5_pl5}`

</details>
