## Secrets
To add secret values to your shell environment, make a script in 
this directory called "secrets.sh" that exports the values.  Files 
in this directory will be ignored by git.

### secrets.sh example
```sh
export GITHUB_PERSONAL_ACCESS_TOKEN="<wouldn't you like to know'>"
```

## Org tools
To add org-specific values to your shell environment, make a script in
this directory called "alias.sh" that sets the aliases.  Files
in this directory will be ignored by git.

### alias.sh example
```sh
# we live in hell so we need terragrunt sometimes
alias tf='terragrunt'
```
