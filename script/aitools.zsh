# Project-aware AI Memory Management
# Creates AI_MEMORY.md in a configurable location and links other AI files to it
# Set AI_MEMORY_PATH environment variable to customize the storage location

ai() {
    case "$1" in
        memory)
            ai_memory
            ;;
        *)
            echo "Usage: ai memory"
            ;;
    esac
}

ai_memory() {
    # Get the base path for AI memory files (configurable via environment variable)
    local ai_memory_base_path="${AI_MEMORY_PATH:-$HOME/.ai-memory}"

    # Get current project path and repo name
    local project_path
    local repo_name

    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        project_path=$(git rev-parse --show-toplevel)
        repo_name=$(basename "$project_path")
    else
        project_path=$(pwd)
        repo_name=$(basename "$project_path")
    fi

    # Full path to the AI memory file for this project
    local ai_memory_dir="${ai_memory_base_path}/${repo_name}"
    local ai_memory_file="${ai_memory_dir}/AI_MEMORY.md"

    # If memory already exists, print the content
    if [[ -f "$ai_memory_file" ]]; then
        echo "📄 AI Memory for ${repo_name}:"
        echo "📁 Location: $ai_memory_file"
        echo
        cat "$ai_memory_file"
        return
    fi

    # If memory doesn't exist, set it up
    # Create the repo directory if it doesn't exist
    mkdir -p "$ai_memory_dir"

    # Create AI_MEMORY.md
    touch "$ai_memory_file"
    echo "✅ Created empty AI_MEMORY.md at: $ai_memory_file"
    echo "💡 You can use Claude Code or Gemini CLI to populate the AI memory."

    # Create symbolic links in the current project directory
    for file in ".augment-guidelines" "CLAUDE.md" "GEMINI.md"; do
        [[ -f "$file" && ! -L "$file" ]] && mv "$file" "${file}.backup"
        [[ -L "$file" ]] && rm "$file"
        ln -s "$ai_memory_file" "$file"
        echo "🔗 Linked $file -> $ai_memory_file"
    done

    echo "🎉 AI memory setup complete!"
    echo "📁 AI memory file: $ai_memory_file"
    echo "💡 Set AI_MEMORY_PATH environment variable to customize storage location"
}
