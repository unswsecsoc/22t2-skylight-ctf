# amend #1

## Authors
- [@joooooooooooooooooooooooooooooooooooosh](https://github.com/joooooooooooooooooooooooooooooooooooosh)

## Category
- misc

## Description

I accidentally pushed a *second* flag to the same repository as last time, but just to be on the safe side I'm not going to give you the commit hash of the orphaned commit with the new flag. Y'know, sekurity and all that. Surely there's no way you'll be able to recover this orphan commit without me telling you the hash!


## Difficulty
- Medium

## Points
80

## Hints
1. Knowing the commit hash is very important, but fortunately the GitHub API can tell you *all* of the events that have happened in a repository, and amending a commit just makes a new event instead of overwriting the existing event...

## Solution
<details>
<summary>Spoiler</summary>

### Idea

GitHub has an Events API that keeps track of everything that happens!

### Walkthrough

#### Note: if you are trying to replicate these steps, keep in mind that the GitHub Events API only keeps track of events for 90 days. Using this method after 90 days will not work unfortunately.

Visiting the GitHub Events API will easily show you everything that happened to a repository in the past 90 days (many people that solved this would likely have done so by finding [this StackOverflow post](https://stackoverflow.com/questions/28958327/does-github-remember-commit-ids/28958418#28958418)).
By visiting `https://api.github.com/repos/unswsecsoc/skylightctf22_amend/events` either in your browser or by making a request with `curl` and looking at the PushEvents you'll find another commit that doesn't exist in the visible history, `e7b908d6fd7fc1b7df623a1816aa6a23b7455460`. You can then use the techniques outlined in the writeup for `amend #0` to view the contents of this commit.

### Flag
`SKYLIGHT{am3nd1ng-do3s-n0t-del3te-f0r3v3r}`
</details>
