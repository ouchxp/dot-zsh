### wait-rollout: Watch kubernetes deployment rollouts with fzf completion

wait-rollout() {
  local context=""
  local target=""
  local kubectl_ctx=""
  local WAIT_ROLLOUT_CACHE

  while (( $# > 0 )); do
    case "$1" in
      --context)
        context="$2"
        kubectl_ctx="--context=$2"
        shift 2
        ;;
      *)
        target="$1"
        shift
        ;;
    esac
  done

  if [[ -n "$context" ]]; then
    WAIT_ROLLOUT_CACHE="${HOME}/.wait-rollout-cache.${context}"
  else
    WAIT_ROLLOUT_CACHE="${HOME}/.wait-rollout-cache"
  fi

  if [[ "$target" == "refresh" ]]; then
    echo "Fetching deployments${context:+ for context: $context}..."
    kubectl ${kubectl_ctx} get deployment -A --no-headers 2>/dev/null | awk '{print $1 "/" $2}' > "$WAIT_ROLLOUT_CACHE"
    local count
    count=$(wc -l < "$WAIT_ROLLOUT_CACHE" | tr -d ' ')
    echo "Cached ${count} deployments to ${WAIT_ROLLOUT_CACHE}"
    return 0
  fi

  if [[ -z "$target" ]]; then
    echo "Usage: wait-rollout [--context <context>] refresh"
    echo "       wait-rollout [--context <context>] <namespace>/<deployment>"
    return 1
  fi

  if [[ ! "$target" =~ "/" ]]; then
    echo "Error: argument must be in <namespace>/<name> format"
    return 1
  fi

  local namespace="${target%%/*}"
  local name="${target##*/}"

  if ! kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" > /dev/null 2>&1; then
    echo "Error: deployment \"${name}\" not found in namespace \"${namespace}\"${context:+ (context: $context)}"
    return 1
  fi

  local last_ts
  last_ts=$(kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" \
    -o jsonpath='{.status.conditions[?(@.type=="Progressing")].lastUpdateTime}' 2>/dev/null)
  echo "Last rollout: $(_wait_rollout_ago "$last_ts")"

  echo "Checking rollout status for ${namespace}/${name}${context:+ (context: $context)}..."

  local max_wait=12000
  local waited=0
  local found=0

  while (( waited < max_wait )); do
    if _wait_rollout_is_active "$namespace" "$name" "$kubectl_ctx"; then
      found=1
      break
    fi

    echo "No active rollout. Waiting... (${waited}s / ${max_wait}s)"
    sleep 10
    waited=$((waited + 10))
  done

  if (( found == 0 )); then
    echo "Timeout: No rollout started within ${max_wait} seconds"
    return 1
  fi

  echo "Active rollout detected. Waiting for completion..."
  if kubectl ${kubectl_ctx} rollout status deployment/"$name" -n "$namespace"; then
    echo ""
    echo "Rollout completed: ${namespace}/${name}"
    kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" -o wide
    return 0
  else
    echo ""
    echo "Rollout failed or timed out: ${namespace}/${name}"
    return 1
  fi
}

_wait_rollout_ago() {
  local ts="$1"
  if [[ -z "$ts" ]]; then
    echo "unknown"
    return
  fi

  local then now diff
  then=$(TZ=UTC date -j -f "%Y-%m-%dT%H:%M:%SZ" "$ts" "+%s" 2>/dev/null)
  if [[ -z "$then" ]]; then
    echo "unknown"
    return
  fi

  now=$(date "+%s")
  diff=$(( now - then ))

  if (( diff < 60 )); then
    echo "${diff}s ago"
  elif (( diff < 3600 )); then
    echo "$(( diff / 60 ))mins ago"
  elif (( diff < 86400 )); then
    local h=$(( diff / 3600 ))
    local m=$(( (diff % 3600) / 60 ))
    if (( m == 0 )); then
      echo "${h}hrs ago"
    else
      echo "${h}hrs ${m}mins ago"
    fi
  else
    local d=$(( diff / 86400 ))
    local h=$(( (diff % 86400) / 3600 ))
    if (( h == 0 )); then
      echo "${d}days ago"
    else
      echo "${d}days ${h}hrs ago"
    fi
  fi
}

_wait_rollout_is_active() {
  local namespace="$1"
  local name="$2"
  local kubectl_ctx="$3"

  local condition
  condition=$(kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" -o jsonpath='{.status.conditions[?(@.type=="Progressing")].reason}' 2>/dev/null)

  if [[ "$condition" == "NewReplicaSetAvailable" ]]; then
    return 1
  fi

  local generation observed
  generation=$(kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" -o jsonpath='{.metadata.generation}' 2>/dev/null)
  observed=$(kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" -o jsonpath='{.status.observedGeneration}' 2>/dev/null)

  if [[ -n "$generation" && -n "$observed" && "$generation" != "$observed" ]]; then
    return 0
  fi

  local desired updated unavailable
  desired=$(kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" -o jsonpath='{.status.replicas}' 2>/dev/null)
  updated=$(kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" -o jsonpath='{.status.updatedReplicas}' 2>/dev/null)
  unavailable=$(kubectl ${kubectl_ctx} get deployment "$name" -n "$namespace" -o jsonpath='{.status.unavailableReplicas}' 2>/dev/null)

  if [[ -n "$unavailable" && "$unavailable" != "0" ]]; then
    return 0
  fi

  if [[ -n "$desired" && -n "$updated" && "$updated" != "$desired" ]]; then
    return 0
  fi

  return 1
}
