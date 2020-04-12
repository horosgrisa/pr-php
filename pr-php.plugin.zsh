#!/usr/bin/env zsh

: ${PHP_PREFIX:=" "}
: ${PHP_SUFIX:=""}

typeset -g pr_php=""

if (( $+commands[php] )); then
  function _pr_php() {
    pr_php=""

    if is-recursive-exist composer.json || is-recursive-exist index.php; then
      local -a lines=( ${(f)"$(command php --version)"} )
      local -a arr_mod=("${(@s/ /)lines[1]}")
      local php_version=$arr_mod[2]

      pr_php="${PHP_PREFIX}%{${c[magenta]}${c[bold]}%}𝗛%{${c[reset]}%} %{${c[blue]}${c[bold]}%}$php_version%{${c[reset]}%}${PHP_SUFIX}"
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_php
  _pr_php
fi
