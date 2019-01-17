# Automatically download and switch kubenetes-cli according to the cluster version

_k5l() {
    if ! hash kubectl 2>/dev/null; then
        echo "Pleast install latest version kubectl first. e.g. brew install kubectl"
    fi

    # Command that not required a cluser are escaped here
    if [[ $* =~ ([[:space:]]*)(config|help|completion|options)([[:space:]]*) ]]
    then
        command kubectl $@
        return
    fi

    local context=""
    if [[ $* =~ --context(=|[[:space:]]*)([^[:space:]]*) ]]
    then
        context="${match[2]}${BASH_REMATCH[2]}"
    fi

    if [ -f ~/.kube/bin/kubectl-$context ]
    then
        ~/.kube/bin/kubectl-$context $@
    else
        # download binary if necessary
        context_arg=""
        if [ ! -z "$context" ]
        then
            context_arg="--context=$context"
        fi

        local server_version_str=$(command kubectl $context_arg version | tail -1)
        local server_version=""
        if [[ $server_version_str = Server* && $server_version_str =~ GitVersion:\"v([^\"]*)\" ]]
        then
            server_version="${match[1]}${BASH_REMATCH[1]}"
            local platform=$([[ $OSTYPE == *darwin* ]] && echo "darwin" || echo "linux")
            [ -d ~/.kube/bin/ ] || mkdir -p ~/.kube/bin/
            echo "k5l: dowloading kubectl $server_version for context $context ..."
            curl -# -Lo ~/.kube/bin/kubectl-$context "https://storage.googleapis.com/kubernetes-release/release/v$server_version/bin/$platform/amd64/kubectl"
            chmod +x ~/.kube/bin/kubectl-$context
            echo "k5l: done. To update the client binary please delete ~/.kube/bin/kubectl-$context"
            ~/.kube/bin/kubectl-$context $@
        else
            echo "k5l: server version unavaliable"
        fi
    fi
}
