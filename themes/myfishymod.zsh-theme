# ZSH Theme emulating the Fish shell's default prompt.
_fishy_collapsed_wd() {
  echo ${PWD/#$HOME/'~'} | awk -F '/' '
    BEGIN{ORS="/"}
    {
      for (i = 1; i < NF; i++) {
        if (length($i) <= 3) print $i;
        else print substr($i,0,1)
      }
    }
    END {ORS=""; print $NF;}
  '
}

_node_version() {
  if [[ $(typeset -f nodenv) ]]; then
    local ver=$(nodenv version-name)
    local global=$(nodenv global)
    if [[ $ver != $global  ]]; then
      echo " %{$fg[green]%}⬢ $ver%{$reset_color%}"
    fi
  fi
}

_python_version() {
  if [[ $(typeset -f pyenv) ]]; then
    local ver=$(pyenv version-name)
    local global=$(pyenv global)
    if [[ $ver != $global  ]]; then
      echo " %{$fg[blue]%}🐍 $ver%{$reset_color%}"
    fi
  fi
}

_aws_vault_info() {
  if [[ -n $AWS_VAULT ]]; then
    echo "%{$fg[yellow]%}($AWS_VAULT)%{$reset_color%} "
  fi
}

local user=''; [ $UID -eq 0 ] && user="%{$fg[red]%}%n@%m%{$reset_color%}"
PROMPT='${user} $(_aws_vault_info)%{$fg[green]%}$(_fishy_collapsed_wd)%{$reset_color%}%(!.#.>) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status=" %{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
RPROMPT='${return_status}$(_awsGetProfile 2> /dev/null)$(_python_version)$(_node_version)$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[magenta]%}$"