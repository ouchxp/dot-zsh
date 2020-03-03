source ~/.zinit/bin/zinit.zsh

zinit snippet OMZ::lib/directories.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/history/history.plugin.zsh
zinit snippet OMZ::plugins/extract/extract.plugin.zsh
zinit load rupa/z
zinit load changyuheng/fz
zinit load changyuheng/zsh-interactive-cd
zinit ice wait lucid
zinit load zdharma/fast-syntax-highlighting
zinit ice pick"shell/completion.zsh" src"shell/key-bindings.zsh"
zinit load junegunn/fzf
zinit ice wait'[[ $(typeset -f fzf-file-widget) ]]' lucid # load after fzf shell
zinit snippet ~/.zsh/script/fzf.zsh
zinit snippet ~/.zsh/script/alias.zsh
zinit snippet ~/.zsh/script/aws.zsh
zinit snippet ~/.zsh/script/k5l.zsh
zinit snippet ~/.zsh/script/notifier.zsh
zinit ice wait lucid
zinit snippet ~/.zsh/script/xenv.zsh
zinit snippet ~/.zsh/themes/myfishymod.zsh-theme

# Binaries
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin
zinit ice from"gh-r" as"program" mv"*/ccat -> cat"
zinit load jingweno/ccat

# Misc
[ -f /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
[ -f ~/.iterm2_shell_integration.zsh ] && test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.`basename $SHELL`
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
