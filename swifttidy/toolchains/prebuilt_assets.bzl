"""Support downloading prebuilt SwiftFormat binaries."""

load("@bazel_skylib//lib:types.bzl", "types")

# _VALID_TOOLS = ["swiftformat"]

def _create(
        os,
        cpu,
        file,
        urls,
        executable_label,
        repo,
        sha256 = None,
        swiftformat_toolchain_name = None,
        toolchain_name = None):
    """Create an asset.

    Args:
        os: The operating system name as a `string`.
        cpu: The cpu as a `string`.
        file: The name of the executable in the archive as a `string`.
        urls: A `list` of urls to download the archive file that contains the
            executable.
        executable_label: The label for the executable as a `string`.
        repo: The name of the repository for the downloaded archive as a
            `string`.
        sha256: Optional. The SHA256 value for the archive as a `string`.
        swiftformat_toolchain_name: Optional. The name for the
            `swiftformat_toolchain` as a `string`.
        toolchain_name: Optional. The name of the `toolchain` as a `string`.

    Returns:
        A `struct` representing a downloadable asset.
    """
    if swiftformat_toolchain_name == None:
        swiftformat_toolchain_name = repo
    if toolchain_name == None:
        toolchain_name = swiftformat_toolchain_name + "_toolchain"
    return struct(
        os = os,
        cpu = cpu,
        file = file,
        urls = urls,
        repo = repo,
        swiftformat_toolchain_name = swiftformat_toolchain_name,
        toolchain_name = toolchain_name,
        executable_label = executable_label,
        sha256 = sha256,
    )

_SWIFTFORMAT_DOWNLOAD_URL_TEMPLATE = """\
https://github.com/nicklockwood/SwiftFormat/releases/download/{version}/{archive}\
"""

def _create_swiftformat(version, os, cpu, file = None, sha256 = None):
    """Create an asset declaration for the swiftformat tool.

    Args:
        version: The version as a `string`.
        os: The operating system name as a `string`.
        cpu: The cpu as a `string`.
        file: Optional. The name of the executable in the archive as a `string`.
        sha256: Optional. The SHA256 value for the archive file as a `string`.

    Returns:
        An asset `struct` as returned by `prebuilt_assets.create()`.
    """
    repo = "swiftformat_download_{os}_{cpu}".format(
        os = os,
        cpu = cpu,
    )
    if file == None:
        file = "swiftformat_linux" if os == "linux" else "swiftformat"
    archive = file + ".zip"
    return _create(
        os = os,
        cpu = cpu,
        file = file,
        urls = [
            _SWIFTFORMAT_DOWNLOAD_URL_TEMPLATE.format(
                version = version,
                archive = archive,
            ),
        ],
        executable_label = "@{repo}//:executable".format(repo = repo),
        repo = repo,
        sha256 = sha256,
    )

def _from_json(json_str):
    """Returns an asset `struct` or a `list` of asset `struct` values as \
    represented by the JSON `string`.

    Args:
        json_str: A JSON `string` representing an asset or a list of assets.

    Returns:
        An asset `struct` or a `list` of asset `struct` values.
    """
    result = json.decode(json_str)
    if types.is_list(result):
        return [_create(**a) for a in result]
    elif types.is_dict(result):
        return _create(**result)
    fail("Unexpected result type decoding JSON string. %s" % (json_str))

prebuilt_assets = struct(
    create = _create,
    create_swiftformat = _create_swiftformat,
    from_json = _from_json,
)
