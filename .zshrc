source ~/.zinit/bin/zinit.zsh

# Binaries
zinit from"gh-r" as"program" for junegunn/fzf-bin
zinit from"gh-r" as"program" mv"exa-* -> exa" for ogham/exa
zinit from"gh-r" as"program" mv"jq-* -> jq" for stedolan/jq
zinit from"gh-r" as"program" pick"*/rg" for BurntSushi/ripgrep
zinit from"gh-r" as"program" pick"*/bat" for @sharkdp/bat
zinit from"gh-r" as"program" pick"*/**/terminal-notifier" for julienXX/terminal-notifier

# Oh-My-Zsh snippets
zinit is-snippet for OMZ::lib/directories.zsh
zinit is-snippet for OMZ::lib/theme-and-appearance.zsh
zinit is-snippet for OMZ::lib/key-bindings.zsh
zinit is-snippet for OMZ::lib/history.zsh
zinit is-snippet for OMZ::lib/git.zsh
zinit is-snippet for OMZ::plugins/git/git.plugin.zsh
zinit is-snippet for OMZ::plugins/history/history.plugin.zsh
zinit is-snippet for OMZ::plugins/extract/extract.plugin.zsh
zinit atload"zpcompinit" lucid as"completion" for OMZ::plugins/docker/_docker

# Plugins
zinit for rupa/z
zinit for changyuheng/fz
zinit for changyuheng/zsh-interactive-cd
zinit wait lucid for zdharma/fast-syntax-highlighting
zinit pick"shell/completion.zsh" src"shell/key-bindings.zsh" for junegunn/fzf

# Local snippets
zinit wait'[[ $(typeset -f fzf-file-widget) ]]' lucid is-snippet for ~/.zsh/script/fzf.zsh # load after fzf shell
zinit wait lucid is-snippet for ~/.zsh/script/xenv.zsh
zinit is-snippet for ~/.zsh/script/alias.zsh
zinit is-snippet for ~/.zsh/script/aws.zsh
zinit is-snippet for ~/.zsh/script/k5l.zsh
zinit is-snippet for ~/.zsh/script/notifier.zsh
zinit is-snippet for ~/.zsh/themes/myfishymod.zsh-theme

# Misc
[ -f /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
[ -f ~/.iterm2_shell_integration.zsh ] && test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.`basename $SHELL`
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
