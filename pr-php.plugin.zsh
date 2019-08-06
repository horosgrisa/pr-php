#!/usr/bin/env zsh

DEPENDENCES_ZSH+=( zpm-zsh/helpers zpm-zsh/colors )

PHP_PREFIX=${PHP_PREFIX:-" "}
PHP_SUFIX=${PHP_SUFIX:-""}


if command -v zpm >/dev/null; then
  zpm zpm-zsh/helpers zpm-zsh/colors
fi

pr_php=""

_pr_php() {
  
  if (( $+commands[php] )); then
    if is-recursive-exist composer.json || is-recursive-exist index.php >/dev/null ; then
      pr_php="$PHP_PREFIX"
      
      php_version=$(
        php --version | sed 1q | awk '{print $2}' | awk -F'-' '{print $1}'
      )
      if [[ $CLICOLOR = 1 ]]; then
        pr_php+="%{$c[magenta]${c_bold}%}H%{$c_reset%} %{$c[blue]$c_bold%}$php_version%{$c_reset%}"
      else
        pr_php+="H $php_version"
      fi
      
      pr_php+="$PHP_SUFIX"
      return 0
    fi
  fi
  
  pr_php=""
  
}

_pr_php
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _pr_php
