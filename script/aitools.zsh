# Project-aware AI Memory Management
# Creates AI_MEMORY.md in a configurable location and links other AI files to it
# Set AI_MEMORY_PATH environment variable to customize the storage location

ai() {
    case "$1" in
        memory)
            shift
            ai_memory "$@"
            ;;
        *)
            echo "Usage: ai memory [global]"
            ;;
    esac
}

_ai_memory_link() {
    # $1 = target file, $2 = link path (absolute or relative)
    local target="$1"
    local link="$2"
    local link_dir="${link:h}"
    local link_name="${link:t}"

    (
        cd "$link_dir" || exit 1
        if [[ -L "$link_name" && "$(readlink "$link_name")" == "$target" ]]; then
            return 1
        fi
        [[ -f "$link_name" && ! -L "$link_name" ]] && mv "$link_name" "${link_name}.backup"
        [[ -L "$link_name" ]] && rm "$link_name"
        ln -s "$target" "$link_name"
        echo "🔗 Linked $link -> $target"
        return 0
    )
}

ai_memory() {
    if [[ "$1" == "global" ]]; then
        ai_memory_global
        return
    fi

    local ai_memory_base_path="${AI_MEMORY_PATH:-$HOME/.ai-memory}"
    local project_path
    local repo_name

    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        project_path=$(git rev-parse --show-toplevel)
        repo_name=$(basename "$project_path")
    else
        project_path=$(pwd)
        repo_name=$(basename "$project_path")
    fi

    local ai_memory_dir="${ai_memory_base_path}/${repo_name}"
    local ai_memory_file="${ai_memory_dir}/AI_MEMORY.md"

    if [[ ! -f "$ai_memory_file" ]]; then
        mkdir -p "$ai_memory_dir"
        touch "$ai_memory_file"
        echo "✅ Created empty AI_MEMORY.md at: $ai_memory_file"
        echo "💡 You can use coding agent to populate the AI memory."
    fi

    local links_created=0
    for file in "CLAUDE.local.md" "AGENTS.md"; do
        if _ai_memory_link "$ai_memory_file" "${project_path}/${file}"; then
            links_created=1
        fi
    done

    if [[ $links_created -eq 1 ]]; then
        echo "🎉 AI memory setup complete!"
    else
        echo "📄 AI Memory for ${repo_name}:"
        echo
        cat "$ai_memory_file"
    fi
    echo "📁 AI memory file: $ai_memory_file"
}

ai_memory_global() {
    local ai_memory_base_path="${AI_MEMORY_PATH:-$HOME/.ai-memory}"
    local ai_memory_dir="${ai_memory_base_path}/global"
    local ai_memory_file="${ai_memory_dir}/AI_MEMORY.md"

    if [[ ! -f "$ai_memory_file" ]]; then
        mkdir -p "$ai_memory_dir"
        touch "$ai_memory_file"
        echo "✅ Created empty AI_MEMORY.md at: $ai_memory_file"
        echo "💡 You can use coding agent to populate the AI memory."
    fi

    local links_created=0
    for file in "CLAUDE.md" "AGENTS.md"; do
        if _ai_memory_link "$ai_memory_file" "${HOME}/${file}"; then
            links_created=1
        fi
    done

    if [[ $links_created -eq 1 ]]; then
        echo "🎉 Global AI memory setup complete!"
    else
        echo "📄 Global AI Memory:"
        echo
        cat "$ai_memory_file"
    fi
    echo "📁 AI memory file: $ai_memory_file"
}
