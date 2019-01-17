source ~/.zplug/init.zsh

local PLATFORM_MATCHER=$([[ $OSTYPE == *darwin* ]] && echo "*darwin*amd64*" || echo "*linux*amd64*")

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "marianogappa/sql", from:gh-r, as:command, rename-to:sql, use:$PLATFORM_MATCHER
zplug "jingweno/ccat", from:gh-r, as:command, rename-to:cat, use:$PLATFORM_MATCHER
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:$PLATFORM_MATCHER
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "rupa/z", use:z.sh
zplug "changyuheng/fz", use:"*.zsh"
zplug "changyuheng/zsh-interactive-cd", use:"*.zsh"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "~/.zsh/script", from:local, on:"junegunn/fzf"
zplug "~/.zsh/themes", from:local, as:theme, use:"myfishymod.zsh-theme"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Misc
[ -f /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
[ -f ~/.iterm2_shell_integration.zsh ] && test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.`basename $SHELL`
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
