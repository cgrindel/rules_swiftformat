#!/usr/bin/env bash

# --- begin runfiles.bash initialization v2 ---
# Copy-pasted from the Bazel Bash runfiles library v2.
set -o nounset -o pipefail; f=bazel_tools/tools/bash/runfiles/runfiles.bash
# shellcheck disable=SC1090
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -o errexit
# --- end runfiles.bash initialization v2 ---

# MARK - Locate Deps

assertions_sh_location=cgrindel_bazel_starlib/shlib/lib/assertions.sh
assertions_sh="$(rlocation "${assertions_sh_location}")" || \
  (echo >&2 "Failed to locate ${assertions_sh_location}" && exit 1)
# shellcheck disable=SC1090
source "${assertions_sh}"

generate_assets_declaration_sh_location=rules_swift_tidy/tools/generate_assets_declaration.sh
generate_assets_declaration_sh="$(rlocation "${generate_assets_declaration_sh_location}")" || \
  (echo >&2 "Failed to locate ${generate_assets_declaration_sh_location}" && exit 1)


# MARK - Set Up a Workspace Directory

# Bazel sh_binary targets expect BUILD_WORKSPACE_DIRECTORY to exist. Because
# we are in a test, we need to fake it out.

repo_dir="${PWD}/repo"
rm -rf "${repo_dir}"
mkdir -p "${repo_dir}"
export "BUILD_WORKSPACE_DIRECTORY=${repo_dir}"

# MARK - Test with Release Tag

actual="$( "${generate_assets_declaration_sh}" "0.51.11" )"
assert_match "version.*0.51.11" "${actual}"
assert_match "os.*macos" "${actual}"
assert_match "os.*linux" "${actual}"
assert_match "cpu.*x86_64" "${actual}"
assert_match "cpu.*arm64" "${actual}"
assert_match "sha256.*e565ebf6c54ee8e1ac83e4974edae34e002f86eda358a5838c0171f32f00ab20" "${actual}"
assert_match "sha256.*a49b79d97c234ccb5bcd2064ffec868e93e2eabf2d5de79974ca3802d8e389ec" "${actual}"
