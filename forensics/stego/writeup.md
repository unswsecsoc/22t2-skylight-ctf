# Title

## Authors
- @RaydenSec

## Category
- Forensics

## Description
I hid a little secret ingredient inside my coffee, but I forgot where I left my key :( Now I'll never be able to enjoy my cup of coffee..

## Difficulty
- Easy

## Points
50

## Hints
1. ...
1. ...

## Files
- [stego.jpg](_ctfd/files/stego.jpg)

## Solution
<details>
<summary>Spoiler</summary>

### Idea
Introduction to looking through file metadata and using steganography. 

### Walkthrough
1. If we download the image file "stego.jpg", we can look at the file's metadata by using exiftool. We can run the command "exiftool stego.jpg" to find hidden information about the file. 
2. While looking through the metadata, we can find a suspicious "Description" with the contents "N0t_A_K3y" beside it. 
3. Since the file is a jpg, and we're given a key, there's a chance that steganography was used to hide data within the file. We can use a tool called steghide to find out if this is the case by running the command "steghide info stego.jpg" and entering the passphrase/key "N0t_A_K3y", which we found earlier in the image's metadata. 
4. We discover that there is an embedded text file called "flag.txt" within the image. 
5. We can run "steghide extract -sf stego.jpg" to extract and download the text file, making sure to enter the password "N0t_A_K3y" for the passphrase once again. 
6. We can now open the text file "flag.txt" and peekaboo, we have found the flag. 

### Flag
`SKYLIGHT{br3wT1fuL_BE@N!_6265e}`
</details>
