#!/bin/bash
# PHP wrapper script to execute PHP commands in the PHP 5.6 container
# This allows VS Code to use PHP 5.6 for linting, IntelliSense, etc.

# Function to check if PHP 5.6 container is running
is_container_running() {
    docker ps --format '{{.Names}}' 2>/dev/null | grep -q '^php56-legacy$'
}

# Function to execute PHP in container with proper path mapping
execute_in_container() {
    local args=("$@")
    local file_args=()
    local other_args=()
    
    # Separate file arguments from other arguments
    for arg in "${args[@]}"; do
        if [[ -f "$arg" ]] && [[ "$arg" == *.php ]]; then
            # Convert absolute workspace paths to container paths
            if [[ "$arg" == /workspace/* ]]; then
                # Map /workspace/source/* to /var/www/html/*
                local container_path="/var/www/html${arg#/workspace/source}"
                file_args+=("$container_path")
            elif [[ "$arg" == /workspace/* ]]; then
                # For other workspace files, try to map them
                local rel_path="${arg#/workspace/}"
                if [[ "$rel_path" == source/* ]]; then
                    local container_path="/var/www/html/${rel_path#source/}"
                    file_args+=("$container_path")
                else
                    file_args+=("$arg")
                fi
            else
                file_args+=("$arg")
            fi
        else
            other_args+=("$arg")
        fi
    done
    
    # Execute in container
    if [[ ${#file_args[@]} -gt 0 ]]; then
        docker exec php56-legacy php "${file_args[@]}" "${other_args[@]}"
    else
        docker exec php56-legacy php "${args[@]}"
    fi
}

# Main execution
if ! is_container_running; then
    # Container not running - try to use local PHP as fallback
    if command -v php >/dev/null 2>&1; then
        # Use local PHP but warn about version mismatch
        echo "Warning: PHP 5.6 container not running, using local PHP" >&2
        exec php "$@"
    else
        echo "Error: PHP 5.6 container not running and no local PHP found" >&2
        echo "Start the container: cd php56-setup && ./start-php56.sh" >&2
        exit 1
    fi
fi

# Container is running - execute command
execute_in_container "$@"
