#!/usr/bin/env bash

# --- begin runfiles.bash initialization v2 ---
# Copy-pasted from the Bazel Bash runfiles library v2.
set -uo pipefail; f=bazel_tools/tools/bash/runfiles/runfiles.bash
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e
# --- end runfiles.bash initialization v2 ---

assertions_sh_location=cgrindel_bazel_starlib/shlib/lib/assertions.sh
assertions_sh="$(rlocation "${assertions_sh_location}")" || \
  (echo >&2 "Failed to locate ${assertions_sh_location}" && exit 1)
source "${assertions_sh}"

create_scratch_dir_sh_location=rules_bazel_integration_test/tools/create_scratch_dir.sh
create_scratch_dir_sh="$(rlocation "${create_scratch_dir_sh_location}")" || \
  (echo >&2 "Failed to locate ${create_scratch_dir_sh_location}" && exit 1)


# MARK - Process Flags

bazel="${BIT_BAZEL_BINARY:-}"
workspace_dir="${BIT_WORKSPACE_DIR:-}"

# Process args
while (("$#")); do
  case "${1}" in
    "--bazel")
      bazel="${2}"
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

[[ -n "${bazel:-}" ]] || fail "Must specify the location of the Bazel binary."
[[ -n "${workspace_dir:-}" ]] || fail "Must specify the location of the workspace directory."


# MARK - Create Scratch Directory

scratch_dir="$("${create_scratch_dir_sh}" --workspace "${workspace_dir}")"
cd "${scratch_dir}"

# MARK - Test Change, Test, and Update All

# Should not fail, no changes
"${bazel}" test //... || fail "Expected test to succeed as nothing has changed yet."

# Modify the file
# The spaces at the front of the statement should be removed by the formatter.
echo "     let bar = 2" >> main.swift

# Should fail due to unformatted
"${bazel}" test //... && fail "Expected test to fail due to unformatted files."

# Format the Swift files and copy them back to the workspace
"${bazel}" run //:update_all || fail "Expected update_all to succeed."

# This should succeed now that the formatted files have been updated
"${bazel}" test //... || fail "Expected test to succeed after update_all."
