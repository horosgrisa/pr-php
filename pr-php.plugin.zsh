#!/usr/bin/env zsh

typeset -g PHP_PREFIX=${PHP_PREFIX:-" "}
typeset -g PHP_SUFIX=${PHP_SUFIX:-""}
typeset -g pr_php=""

if (( $+functions[zpm] )); then
  zpm zpm-zsh/helpers zpm-zsh/colors
fi

if (( $+commands[php] )); then
  function _pr_php() {
    pr_php=""

    if is-recursive-exist composer.json >/dev/null || is-recursive-exist index.php >/dev/null; then
      local -a lines=( ${(f)"$(command php --version)"} )
      local -a arr_mod=("${(@s/ /)lines[1]}")
      local php_version=$arr_mod[2]

      pr_php="${PHP_PREFIX}%{$c[magenta]${c_bold}%}𝗛%{$c_reset%} %{$c[blue]$c_bold%}$php_version%{$c_reset%}${PHP_SUFIX}"
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_php
  _pr_php
fi
