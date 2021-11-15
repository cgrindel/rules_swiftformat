#!/usr/bin/env bash

set -euo pipefail

# Switch the default Xcode to be incompatible, then use DEVELOPER_DIR 
# attribute on spm_repositories to specify the one that should be used.

exit_on_error() {
  local err_msg="${1:-}"
  [[ -n "${err_msg}" ]] || err_msg="Unspecified error occurred."
  echo >&2 "${err_msg}"
  exit 1
}

normalize_path() {
  local path="${1}"
  if [[ -d "${path}" ]]; then
    local dirname="$(dirname "${path}")"
  else
    local dirname="$(dirname "${path}")"
    local basename="$(basename "${path}")"
  fi
  dirname="$(cd "${dirname}" > /dev/null && pwd)"
  if [[ -z "${basename:-}" ]]; then
    echo "${dirname}"
  fi
  echo "${dirname}/${basename}"
}

starting_dir="$(pwd)"
bazel_cmds=()

# Process args
while (("$#")); do
  case "${1}" in
    "--bazel")
      bazel_rel_path="${2}"
      shift 2
      ;;
    "--bazel_cmd")
      bazel_cmds+=("${2}")
      shift 2
      ;;
    "--workspace")
      workspace_path="${2}"
      shift 2
      ;;
    *)
      shift 1
      ;;
  esac
done


[[ -n "${bazel_rel_path:-}" ]] || exit_on_error "Must specify the location of the Bazel binary."
[[ -n "${workspace_path:-}" ]] || exit_on_error "Must specify the location of the workspace file."

starting_path="$(pwd)"
starting_path="${starting_path%%*( )}"
bazel="$(normalize_path "${bazel_rel_path}")"

workspace_dir="$(dirname "${workspace_path}")"
cd "${workspace_dir}"

# BEGIN Custom test logic 

modified_file="main.swift"
backup_file="${modified_file}.orig"

# Rename the file and copy the contents of the symlink to the original filename
# This should handle if the source if a symlink or the actual file.
mv "${modified_file}" "${backup_file}"
cp "${backup_file}" "${modified_file}"

# Set trap for cleanup
cleanup() {
  mv -f "${backup_file}" "${modified_file}"
  cd "${starting_dir}"
}
trap cleanup EXIT

# Modify the file
# The spaces at the front of the statement should be removed by the formatter.
echo "     let bar = 2" >> main.swift

# Format the Swift files and copy them back to the workspace
"${bazel}" run //:update_all

# This should succeed now that the formatted files have been updated
"${bazel}" test //...

# END Custom test logic 
