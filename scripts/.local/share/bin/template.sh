#!/usr/bin/env bash

# Most part taken from https://sharats.me/posts/shell-script-best-practices/

# Exit when a command fails.
set -o errexit

# Fail the script when some unset variable is used.
set -o nounset

# Fail the script when a command in pipe fails.
set -o pipefail

# To enable script execution with traces, use TRACE=1 ./script.sh
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

run_main() {
    cmd="${1-}"
    case $cmd in
        "" | "-h" | "--help")
            run_help
            exit
            ;;
        "new")
            shift
            # `shellcheck` suggests to enquote argument given to `run_new`, but enquoting arguemnt will result in
            # multiple artuments being converted single string argument with spaces, which we do not want. Hence
            # disabling this check here.
            # shellcheck disable=SC2068
            run_new $@
            ;;
        *)
            echo "Unknown command."
            run_help
            exit 1
            ;;
    esac
}

run_help() {
    echo 'Create new script with template.
    Usage: ./template.sh new <new_script_name>
    Options:
        -h, --help show this message.'
}

run_new() {
    script_abs_path=$(dirname -- "$0")/$(basename -- "$0")
    cp -i "${script_abs_path}" "$1"
}

run_main "$@"
