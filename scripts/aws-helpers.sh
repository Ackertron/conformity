__fzf_file_cmd="find -L . -mindepth 1 -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null | cut -b 3-"
__fzf_dir_cmd="find -L . -mindepth 1 -path '*/\.*' -prune -o -type d -print 2> /dev/null | cut -b 3-"

# Optionally change this to suit your environment
__aws_cmd="aws"

__aws_sso_url="https://upside-services.awsapps.com/start"
__aws_sso_region="us-east-1"
__aws_profile_region_default="us-east-1"

# For interactively configuring your aws config profiles
function aws-config {
  cat 1>&2 << EOL
+-------------+
| 1: SSO info |
+-------------+
| - SSO start URL: ${__aws_sso_url}
| - SSO region:    ${__aws_sso_region}
+--------------------------------+
| 2: Browser challenge/response  |
+--------------------------------+
| 3: Choose account & role       |
+--------------------------------+
| 4: CLI defaults & profile name |
+--------------------------------+
| - Client Region: ${__aws_profile_region_default} probably best
| - Output format: json, text, table, yaml, yaml-stream (depends on your workflow)
| - Profile name:  Pick something memorable (like "prod-[role]" for 337)
+---+
EOL
  eval "$__aws_cmd configure sso"
  cat 1>&2 << EOL
+-------------------------------------------+
| Pssst, or you could just use \`aws-env\`... |
+-------------------------------------------+

EOL
}

# Helper function
function __has_fzf {
  [[ -x "$(command -v fzf)" ]] && return 0 || return 1
}

# Helper function
function __has_require_aws2-wrap {
  if [[ -x "$(command -v aws2-wrap)" ]]; then return 0
  else
    echo -e "aws2-wrap is a required dependancy. You can get it with brew or pip. So sorry :'|\n"
    return 1
  fi
}

# For switching your aws-specific shell envs for use by awscli, terraform, etc
function aws-env {
  if ! __has_require_aws2-wrap ; then return 1; fi

  if [[ $1 == '-h' || $1 == '--help' || $1 == "help" ]]; then
    cat 1>&2 << EOL
USAGE: aws-env
       aws-env [aws_profile]

EOL
    return 1
  fi

  local profile=""

  if [[ -n "$1" ]]; then local profile="$1"
  else
    if ! __has_fzf ; then
      echo "Fuzzy Finder (\`fzf\`) required to run this program without arguments\n"
      return 1
    fi

    local profile="$(grep profile "$HOME/.aws/config" | grep -v default | fzf | cut -d ' ' -f 2)"
    local profile="${profile: 0: ${#profile} - 1}"
  fi

  echo "Loading AWS environment variables for \"$profile\" profile"
  eval "$(aws2-wrap --profile "$profile" --export)"

  echo ""
}

# For refreshing your aws API token (also switches aws env)
function aws-login {
  if [[ $1 == '-h' || $1 == '--help' || $1 == "help" ]]; then
    cat 1>&2 << EOL
USAGE: aws-login
       aws-login [aws_profile]

EOL
    return 1
  fi

  local profile=""

  if [[ -n "$1" ]]; then local profile="$1"
  else
    if ! __has_fzf ; then
      echo "Fuzzy Finder (\`fzf\`) required to run this program without arguments\n"
      return 1
    fi

    local profile="$(grep profile "$HOME/.aws/config" | grep -v default | fzf | cut -d ' ' -f 2)"
    local profile="${profile: 0: ${#profile} - 1}"
  fi

  eval "$__aws_cmd sso login --profile $profile"
  aws-env "$profile"
}