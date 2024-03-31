#!/usr/bin/env bash

# Fail script immediately on any errors in external commands and print a message
set -eo pipefail

# This script's name as the user sees it (used for error messages)
# script_name=$(basename "$0")

# Function to handle errors and script termination
handle_error() {
  exit_code=$?
  echo "Error on line $1: command exited with status $exit_code."
  exit "$exit_code"
}

# trap command can be used to trap signals and execute commands when those signals are received
# Here we trap errors and execute handle_error function, passing line number
trap 'handle_error $LINENO' ERR

# We set IFS (Internal Field Separator) to new line and tab to prevent word splitting issues
IFS=$'\n\t'

# sanitize_input() {
#   local input=$1
#   # Allow only alphanumeric and dash, replace others with underscore
#   local sanitized=$(echo "$input" | tr -dc '[:alnum:]-')
#   sanitized=$(echo "$sanitized" | cut -c 1-200)
#   echo "$sanitized"
# }

init_templates() {
  cabal init --non-interactive --license=MIT --author=Zarak --libandexe --tests --language=GHC2021 --no-comments
  nix flake init --template 'github:zarak/flakes#haskell'
}

customize_templates() {
  current_directory=$(basename "$(pwd)")
  sed -i "s/throw \"put your package name here\!\"/\"${current_directory}\"/g" flake.nix
  sed -i "0,/\(LIBRARY_NAME=\)/s//\1${current_directory}/" Makefile
  echo -e "[![Haskell CI](https://github.com/zarak/${current_directory}/actions/workflows/test.yml/badge.svg)](https://github.com/zarak/${current_directory}/actions/workflows/test.yml)" >> README.md
}

init_git() {
  git init 
  git add .
  git commit -m "Initial commit"
}

init_repo() {
  gh repo create --source=. --private --remote=origin --push
}

enable_flakes() {
  echo "use flake" > .envrc 
  direnv allow
}

main() {
  init_templates
  customize_templates
  enable_flakes

  init_git
  init_repo
}

main

# Always end your script by explicitly exiting with success status code
exit 0
