# User configuration
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/Go
export GO111MODULE=on
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOROOT/bin:$GOPATH/bin:$HOME/.cargo/bin:/usr/local/opt/libpq/bin/"
export MANPATH="/usr/local/man:$MANPATH"
export FZF_DEFAULT_OPTS="--color=pointer:15,fg:247,fg+:15,hl:10 --cycle --bind=tab:accept"
export FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger,$print_query' # For continuous completion and print query
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --bind=tab:accept,btab:up,change:top,ctrl-space:toggle --cycle
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
    --print-query
)
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
