#!/usr/bin/env bash
shopt -s globstar

REPO_ROOT=$(git rev-parse --show-toplevel)
export REPO_ROOT
CLUSTER_ROOT="${REPO_ROOT}/cluster"
export CLUSTER_ROOT

# MacOS work-around for sed
if [ "$(uname)" == "Darwin" ]; then
    # Check if gnu-sed exists
    command -v gsed >/dev/null 2>&1 || {
        echo >&2 "gsed is not installed. Aborting."
        exit 1
    }
    # Export path w/ gnu-sec
    export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# Ensure these cli utils exist
command -v kubectl >/dev/null 2>&1 || {
    echo >&2 "kubectl is not installed. Aborting."
    exit 1
}
command -v envsubst >/dev/null 2>&1 || {
    echo >&2 "envsubst is not installed. Aborting."
    exit 1
}
command -v yq >/dev/null 2>&1 || {
    echo >&2 "yq is not installed. Aborting."
    exit 1
}

# Check for environment variables
[ -n "${DOMAIN}" ] || {
    echo >&2 "Environment variables are not set. Aborting."
    exit 1
}