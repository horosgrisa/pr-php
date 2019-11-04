#!/usr/bin/env zsh

DEPENDENCES_ZSH+=( zpm-zsh/helpers zpm-zsh/colors )

PHP_PREFIX=${PHP_PREFIX:-" "}
PHP_SUFIX=${PHP_SUFIX:-""}


if (( $+function[zpm] )); then
  zpm zpm-zsh/helpers zpm-zsh/colors
fi

pr_php=""

_pr_php() {
  if (( $+commands[php] )); then
    if is-recursive-exist composer.json >/dev/null \
    || is-recursive-exist index.php >/dev/null ; then
      pr_php="$PHP_PREFIX"
      
      php_version=$(
        php --version | sed 1q | awk '{print $2}' | awk -F'-' '{print $1}'
      )
      pr_php+="%{$c[magenta]${c_bold}%}𝗛%{$c_reset%} %{$c[blue]$c_bold%}$php_version%{$c_reset%}"
      pr_php+="$PHP_SUFIX"
      
      return 0
    fi
  fi
  
  pr_php=""
}

_pr_php
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _pr_php
