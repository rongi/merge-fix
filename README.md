# Install

```
brew tap rongi/tap
brew install merge-fix
```

# Use
When on a fix branch

`mergefix`

It will merge current branch into the master branch.

Use `mergefix --no-ff` to force a merge with a merge commit.

# What it does

This single command
- fetches changes from the remote
- rebases fix branch on top of the master branch
- merges fix branch into master branch with --ff-only flag
- pushes everything to the remote
- deletes local and remote fix branches
- brings peace to the world and all the people happy and dancing in joy

It uses --ff-only merge strategy by default, which is only suitable for situations when you don’t want merge commit (bug fixes mostly) Can use --no-ff strategy if corresponding flag is provided.
