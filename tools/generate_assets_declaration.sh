#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>"
  exit 1
fi

readonly version="$1"

download_and_calc_sha256() {
  local url=$1
  local bin
  local sha256
  bin="$(mktemp)"
  curl --fail --silent -L "$url" -o "$bin"
  sha256=$(shasum -a 256 "$bin" | cut -d ' ' -f 1)
  rm -rf "${bin}"
  echo "${sha256}"
}

generate_swiftformat_asset() {
  local ver=$1
  local os=$2
  local cpu=$3
  local file=$4
  local sha256=$5
  cat <<-EOF
        prebuilt_assets.create_swiftformat(
            version = "${ver}",
            os = "${os}",
            cpu = "${cpu}",
            file = "${file}",
            sha256 = "${sha256}",
        ),
EOF
}

# TODO(chuck): UPDATE ME TO SUPPORT BZLMOD AND THE NEW PARAM NAMES

swiftformat_base_url="https://github.com/nicklockwood/SwiftFormat/releases/download/${version}"
assets=()

swiftformat_macos_file="swiftformat"
swiftformat_macos_url="${swiftformat_base_url}/${swiftformat_macos_file}.zip"
swiftformat_macos_sha256="$(download_and_calc_sha256 "${swiftformat_macos_url}")"
assets+=( "$(generate_swiftformat_asset "$version" macos x86_64 "$swiftformat_macos_file" "$swiftformat_macos_sha256")" )
assets+=( "$(generate_swiftformat_asset "$version" macos arm64 "$swiftformat_macos_file" "$swiftformat_macos_sha256")" )

swiftformat_linux_file="swiftformat_linux"
swiftformat_linux_url="${swiftformat_base_url}/${swiftformat_linux_file}.zip"
swiftformat_linux_sha256="$(download_and_calc_sha256 "${swiftformat_linux_url}")"
assets+=( "$(generate_swiftformat_asset "$version" linux x86_64 "$swiftformat_linux_file" "$swiftformat_linux_sha256")" )

cat <<-EOF
load(
    "@rules_swift_tidy//swiftformat:defs.bzl", 
    "swiftformat_register_prebuilt_toolchains", 
    "prebuilt_assets",
)

swiftformat_register_prebuilt_toolchains(
    assets = [
$(printf '%s\n' "${assets[@]}")
    ],
)
EOF
