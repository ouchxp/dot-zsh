# ZSH Theme emulating the Fish shell's default prompt.

# One implementation using awk
# _fishy_collapsed_wd() {
#   echo ${PWD/#$HOME/'~'} | awk -F '/' '
#     BEGIN{ORS="/"}
#     {
#       for (i = 1; i <= NF; i++) {
#         if (length($i) <= 3 || i == NF) print $i;
#         else print substr($i,0,1)
#       }
#     }
#     END { printf "\b" }
#   '
# }

_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

_node_version() {
  local ver=$(nodenv version-name | sed -e "s/system//")
  if [[ !  -z  $ver  ]]; then
    echo " %{$fg[green]%}⬢$ver%{$reset_color%}"
  fi
}

local user=''; [ $UID -eq 0 ] && user="%{$fg[red]%}%n@%m%{$reset_color%}"
PROMPT='${user} %{$fg[green]%}$(_fishy_collapsed_wd)%{$reset_color%}%(!.#.>) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status=" %{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
RPROMPT='${return_status}$(_awsGetProfile 2> /dev/null)$(_node_version)$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

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