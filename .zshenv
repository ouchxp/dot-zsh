# User configuration
export GOROOT=/usr/local/go
export GOPATH=~/go
export PATH="$HOME/.npm-global/bin:/opt/homebrew/opt/mysql-client/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOROOT/bin:$GOPATH/bin:$HOME/.cargo/bin:/usr/local/opt/libpq/bin/:$HOME/.local/bin"
export MANPATH="/usr/local/man:$MANPATH"
export FZF_DEFAULT_OPTS="--color=pointer:15,fg:247,fg+:15,hl:10 --cycle --bind=tab:accept"
export FZF_COMPLETION_TRIGGER="?"
export PYENV_ROOT=~/.pyenv
export RBENV_ROOT=~/.rbenv
export NODENV_ROOT=~/.nodenv
export FZ_CMD=j
export FZ_SUBDIR_CMD=jj
export HIST_STAMPS="yyyy-mm-dd"
export ZSH_HIGHLIGHT_MAXLENGTH=300
export NOTIFICATION_THRESHOLD=120
export NOTIFICATION_BLACKLIST=^(git|tig|vi|vim|ssh|scala|sbt|jshell).*$
export LANG=en_GB.UTF-8
export HOSTNAME=NansMBP
export BAT_CONFIG_PATH=~/.bat.conf
export HOMEBREW_NO_ENV_HINTS=1
export FNM_LOGLEVEL=quiet
export STARSHIP_CONFIG=~/.zsh/starship.toml
export STARSHIP_LOG=error
source ~/.zshenv.local
