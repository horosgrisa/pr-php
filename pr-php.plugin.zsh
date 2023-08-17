#!/usr/bin/env zsh

: ${PR_PHP_SYMBOL:=''}

typeset -g pr_php

if (( $+commands[php] )); then
  function _pr_php() {
    pr_php=''

    if is-recursive-exist composer.json index.php; then
      pr_php=" %{${c[base3]}${c[bold]}%}(%{${c[reset]}%}"

      local -a lines=( ${(f)"$(command php --version)"} )
      local -a arr_mod=("${(@s/ /)lines[1]}")
      local phpver=$arr_mod[2]

      pr_php+="%{${c[violet]}${c[bold]}%}${PR_PHP_SYMBOL}%{${c[reset]}%} %{${c[violet]}${c[bold]}%}$phpver%{${c[reset]}%}"

      pr_php+="%{${c[base3]}${c[bold]}%})%{${c[reset]}%}"

    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_php
  _pr_php
fi
