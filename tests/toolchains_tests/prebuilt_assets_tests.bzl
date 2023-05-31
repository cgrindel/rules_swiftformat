"""Tests for `prebuilt_assets` module."""

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load("//swiftformat/toolchains:prebuilt_assets.bzl", "prebuilt_assets")

def _create_test(ctx):
    env = unittest.begin(ctx)

    actual = prebuilt_assets.create(
        os = "linux",
        cpu = "x86_64",
        file = "sometool_linux",
        urls = ["https://somewhere.com"],
        executable_label = "@sometool_download_linux_x86_64//:tool",
        repo = "sometool_download_linux_x86_64",
        sha256 = "XYZZY",
    )
    expected = struct(
        os = "linux",
        cpu = "x86_64",
        file = "sometool_linux",
        urls = ["https://somewhere.com"],
        executable_label = "@sometool_download_linux_x86_64//:tool",
        repo = "sometool_download_linux_x86_64",
        sha256 = "XYZZY",
        swiftformat_toolchain_name = "sometool_download_linux_x86_64",
        toolchain_name = "sometool_download_linux_x86_64_toolchain",
    )
    asserts.equals(env, expected, actual)

    return unittest.end(env)

create_test = unittest.make(_create_test)

def _create_swiftformat_test(ctx):
    env = unittest.begin(ctx)

    actual = prebuilt_assets.create_swiftformat(
        version = "0.51.11",
        os = "macos",
        cpu = "arm64",
        file = "swiftformat",
        sha256 = "XYZZY",
    )
    expected = struct(
        os = "macos",
        cpu = "arm64",
        file = "swiftformat",
        sha256 = "XYZZY",
        urls = [
            "https://github.com/nicklockwood/SwiftFormat/releases/download/0.51.11/swiftformat.zip",
        ],
        executable_label = "@swiftformat_download_macos_arm64//:executable",
        repo = "swiftformat_download_macos_arm64",
        swiftformat_toolchain_name = "swiftformat_download_macos_arm64",
        toolchain_name = "swiftformat_download_macos_arm64_toolchain",
    )
    asserts.equals(env, expected, actual)

    return unittest.end(env)

create_swiftformat_test = unittest.make(_create_swiftformat_test)

def _from_json_test(ctx):
    env = unittest.begin(ctx)

    assets = [
        prebuilt_assets.create_swiftformat(
            version = "0.51.11",
            os = "macos",
            cpu = "x86_64",
            file = "swiftformat",
            sha256 = "e565ebf6c54ee8e1ac83e4974edae34e002f86eda358a5838c0171f32f00ab20",
        ),
        prebuilt_assets.create_swiftformat(
            version = "0.51.11",
            os = "macos",
            cpu = "arm64",
            file = "swiftformat",
            sha256 = "e565ebf6c54ee8e1ac83e4974edae34e002f86eda358a5838c0171f32f00ab20",
        ),
        prebuilt_assets.create_swiftformat(
            version = "0.51.11",
            os = "linux",
            cpu = "x86_64",
            file = "swiftformat_linux",
            sha256 = "a49b79d97c234ccb5bcd2064ffec868e93e2eabf2d5de79974ca3802d8e389ec",
        ),
    ]
    actual = prebuilt_assets.from_json(json.encode(assets))
    asserts.equals(env, assets, actual)

    return unittest.end(env)

from_json_test = unittest.make(_from_json_test)

def prebuilt_assets_test_suite(name = "prebuilt_assets_tests"):
    return unittest.suite(
        name,
        create_test,
        create_swiftformat_test,
        from_json_test,
    )
