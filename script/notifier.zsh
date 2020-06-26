# Notify when command took longer than threshold
# e.g.
# NOTIFICATION_THRESHOLD=120
# NOTIFICATION_BLACKLIST=^(git|tig|vi|vim|ssh|scala|sbt|jshell).*$

if hash terminal-notifier 2>/dev/null
then
    _nw_preexec() {
      _nw_prev_cmd=$1
      _nw_cmd_timestamp=`date +%s`
    }

    _nw_precmd() {
      local stop=`date +%s`
      local start=${_nw_cmd_timestamp:-$stop}
      let local elapsed=$stop-$start
      [ $elapsed -gt $NOTIFICATION_THRESHOLD ] \
        && [[ ! $_nw_prev_cmd =~ $NOTIFICATION_BLACKLIST ]] \
        && terminal-notifier -title $_nw_prev_cmd -message "Finished in ${elapsed}s" -sound default
      _nw_cmd_timestamp=""
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook preexec _nw_preexec
    add-zsh-hook precmd _nw_precmd
fi
