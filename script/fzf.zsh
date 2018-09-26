### Extra functions for fzf ###

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(
    fc -ln 1 |
    awk '!x[$0]++' |
    FZF_DEFAULT_OPTS="--exact --border --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(q)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    LBUFFER=$selected
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

# CTRL-L - Paste the selected entry from locate output into the command line
fzf-locate-widget() {
  local selected
  # use ag to filter out unwanted file types and dirs
  if selected=$(locate ~ | ag -v 'node_modules|\/\..*|\.class$' | fzf -q "$LBUFFER"); then
    LBUFFER=$selected
  fi
  zle redisplay
}
zle     -N   fzf-locate-widget
bindkey '^L' fzf-locate-widget

# Custom fuzzy completion for "docker" command, modified from https://github.com/junegunn/fzf/issues/760
_fzf_complete_docker() {
  ARGS="$@"
  if [[ $ARGS = 'docker ' ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
        echo 'images'
        echo 'inspect'
        echo 'ps -a'
        echo 'rmi'
        echo 'rm'
        echo 'stop'
        echo 'start'
    )
  elif [[ $ARGS =~ '^docker rmi.*' ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
        docker images --format '{{.Repository}}:{{.Tag}}'
    )
  elif [[ $ARGS =~ '^docker start.*|^docker rm.*' ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
        docker ps -f "status=exited" --format '{{.Names}}'
    )
  elif [[ $ARGS =~ '^docker stop.*|^docker exec.*' ]]; then
    _fzf_complete "--multi --reverse" "$@" < <(
        docker ps --format '{{.Names}}'
    )
  fi
}

# Read kube config to load pods
_fzf_complete_kubectl() {
  ARGS="$@"
  # match cluster name from args
  # kubectl config view -o json | jq '.clusters as $clusters | .contexts[] | select(.name=="cn") | .context.cluster as $cluster_name | $clusters[] | select(.name==$cluster_name) | .cluster.server | rtrimstr(":8443")'
  if [[ $ARGS =~ '^kubectl --context[= ]([^ ]+) ' ]]; then
    local context=$match[1]
    _fzf_complete "--multi --reverse" "$@" < <(
        curl -s $(kubectl config view -o json | jq -r --arg context_name "$context" '.clusters as $clusters | .contexts[] | select(.name==$context_name) as $context | $clusters[] | select(.name==$context.context.cluster) | .cluster.server | rtrimstr(":8443") | "\(.)/api/v1/namespaces/\($context.context.namespace)/pods?pretty=false"') | jq -r '.items[] | .metadata.name'
    )
  fi
}
