# Install

```
brew tap rongi/tap
brew install merge-fix
```

# Use
When on a fix branch
`merge-fix`

# What it does

This single command
- fetches changes from the remote
- rebases fix branch on top of the develop branch
- merges fix branch into develop branch with --ff-only flag
- pushes everything to the remote
- deletes local and remote fix branches
- brings peace to the world and all the people happy and dancing in joy
