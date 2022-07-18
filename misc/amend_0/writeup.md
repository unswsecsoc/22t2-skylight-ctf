# amend #0

## Authors
- [@joooooooooooooooooooooooooooooooooooosh](https://github.com/joooooooooooooooooooooooooooooooooooosh)

## Category
- misc

## Description

I created a tiny GitHub repository over at [https://github.com/unswsecsoc/skylightctf22_amend](https://github.com/unswsecsoc/skylightctf22_amend) and I accidentally stored some of my flags there, but fortunately I redacted it by amending my commit! I just checked the commit history, and the commit hash (c09728a03b211e02e83bb4c57652fd8d2b6c9f42) of the commit when I added the flag is no longer in the history.

This means my flags are safe ...right?


## Difficulty
- Easy

## Points
30

## Hints

## Files


## Solution
<details>
<summary>Spoiler</summary>

### Idea
When using a centralised service like GitHub, it has to keep track of everything you push to it, including commits that aren't a part of your history anymore.

### Walkthrough

There are a few different ways to view commits given the commit hash - here are the two easiest options:

#### Using the GitHub Website

When using the GitHub website, you can view the changes made by any specific commit with a URL of the form `https://github.com/{user}/{repo}/commit/{commit_hash}`.
For example, if you click on the commit message or commit hash of the most recent commit in the `skylightctf22_amend` repo it will bring you to the URL `https://github.com/unswsecsoc/skylightctf22_amend/commit/7f87ef4a63b2d6c2ac9b5ca956702bed51e870f1`.
Simply change the commit hash in the URL to the one you've been given (`https://github.com/unswsecsoc/skylightctf22_amend/commit/c09728a03b211e02e83bb4c57652fd8d2b6c9f42`) and you'll be able to see that a line was added to the `not_flags` file which contained the flag.

#### Using the GitHub CLI

If you tried cloning the repository locally (`git clone https://github.com/unswsecsoc/skylightctf22_amend.git`), you won't be able to find the right commit as Git only fetches the commits that are a part of the history by default. However if you did some searching (e.g. something along the lines of "git download a commit by its hash") you'd find that you could use `git fetch` (or `git pull`) as such - `git fetch origin c09728a03b211e02e83bb4c57652fd8d2b6c9f42`. After fetching, check out that specific commit (`git checkout c09728a03b211e02e83bb4c57652fd8d2b6c9f42`), and view the contents of the `not_flags` file in whatever editor you wish!

### Flag
`SKYLIGHT{hash35-r-v3ry-us3fu1}`
</details>
