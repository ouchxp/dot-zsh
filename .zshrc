eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
source ~/.zinit/bin/zinit.zsh

setopt complete_aliases
setopt nohashcmds

# Oh-My-Zsh snippets
zinit is-snippet for OMZ::lib/theme-and-appearance.zsh
zinit is-snippet for OMZ::lib/git.zsh
zinit is-snippet for OMZ::lib/key-bindings.zsh
zinit wait lucid is-snippet for OMZ::lib/directories.zsh
zinit wait lucid is-snippet for OMZ::lib/history.zsh
zinit wait lucid is-snippet for OMZ::plugins/git/git.plugin.zsh
zinit wait lucid is-snippet for OMZ::plugins/extract/extract.plugin.zsh
zinit wait lucid atload"zpcompinit" lucid as"completion" for OMZ::plugins/docker/completions/_docker
zinit wait lucid is-snippet atload"zpcompinit" lucid as"completion" for ~/.zsh/complete/_aws-vault

# case insensitive comletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Plugins
zinit wait lucid for rupa/z
zinit wait lucid for changyuheng/fz
zinit wait lucid atload"zpcompinit" for Aloxaf/fzf-tab
zinit wait lucid for zdharma-continuum/fast-syntax-highlighting
zinit wait lucid pick"shell/completion.zsh" src"shell/key-bindings.zsh" for junegunn/fzf
zinit wait lucid pick"shell-plugins/shellfirm.plugin.oh-my-zsh.zsh" for kaplanelad/shellfirm
# want to make git cherry-pick have auto-complete of all commits, even it is unreachable

# Local snippets
zinit wait'[[ $(typeset -f fzf-file-widget) ]]' lucid is-snippet for ~/.zsh/script/fzf.zsh # load after fzf shell
zinit wait lucid is-snippet for ~/.zsh/script/xenv.zsh
zinit is-snippet for ~/.zsh/script/alias.zsh
# zinit is-snippet for ~/.zsh/script/aws.zsh
# zinit is-snippet for ~/.zsh/script/k5l.zsh
zinit wait lucid is-snippet for ~/.zsh/script/notifier.zsh
zinit wait lucid is-snippet for ~/.zsh/script/decode.zsh
# zinit is-snippet for ~/.zsh/themes/myfishymod.zsh-theme

# Misc
[ -f /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home -v 11)
[ -f ~/.iterm2_shell_integration.zsh ] && source /Users/nanw/.iterm2_shell_integration.zsh
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# force saving all history
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

# (If were to use fnm) fnm load with higher priority
# command -v fnm &> /dev/null && eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
