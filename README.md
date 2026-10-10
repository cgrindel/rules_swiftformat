# SwiftFormat Rules for Bazel

[![Build](https://github.com/cgrindel/rules_swiftformat/actions/workflows/ci.yml/badge.svg?event=schedule)](https://github.com/cgrindel/rules_swiftformat/actions/workflows/ci.yml)

This repository contains Bazel rules and macros that will format Swift source files using
[nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat), test that the formatted
files exist in the workspace directory, and copy the formatted files to the workspace directory.

## Table of Contents

* [Quickstart](#quickstart)
  * [1\. Add rules\_swift\_tidy to your MODULE\.bazel](#1-add-rules_swift_tidy-to-your-modulebazel)
  * [2\. Update the BUILD\.bazel at the root of your workspace](#2-update-the-buildbazel-at-the-root-of-your-workspace)
  * [3\. Add swiftformat\_pkg to every Bazel package with Swift source files](#3-add-swiftformat_pkg-to-every-bazel-package-with-swift-source-files)
  * [4\. Format, Update, and Test](#4-format-update-and-test)
* [Specifying the SwiftFormat Version](#specifying-the-swiftformat-version)
* [Special Instructions for Linux Users](#special-instructions-for-linux-users)
* [Learn More](#learn-more)

<a id="#quickstart"></a>
## Quickstart

The following provides a quick introduction on how to use the rules in this repository. Also, check
out [the documentation](/doc/) and [the examples](/examples/) for more information.

### 1. Add `rules_swift_tidy` to your `MODULE.bazel`

Add the following to your `MODULE.bazel` file.

<!-- BEGIN MODULE SNIPPET -->
```python
bazel_dep(name = "rules_swift_tidy", version = "0.0.0")
```
<!-- END MODULE SNIPPET -->

The root `BUILD.bazel` in the next step loads from `cgrindel_bazel_starlib`, so add it as a direct
dependency too.

```python
bazel_dep(name = "cgrindel_bazel_starlib", version = "0.18.1")
```

`rules_swift_tidy` is not yet published to the Bazel Central Registry. Until it is, pin a commit
with `git_override`.

```python
git_override(
    module_name = "rules_swift_tidy",
    commit = "<commit>",
    remote = "https://github.com/cgrindel/rules_swiftformat.git",
)
```

### 2. Update the `BUILD.bazel` at the root of your workspace

At the root of your workspace, create a `BUILD.bazel` file, if you don't have one. Add the
following:

```python
load(
    "@cgrindel_bazel_starlib//updatesrc:defs.bzl",
    "updatesrc_update_all",
)

# We export this file to make it available to other Bazel packages in the workspace.
exports_files([".swiftformat"])

# Define a runnable target to copy all of the formatted files to the workspace directory.
updatesrc_update_all(
    name = "update_all",
)
```

The `exports_files` declaration defines a target for your [SwiftFormat configuration file
(`.swiftformat`)](https://github.com/nicklockwood/SwiftFormat#config-file). It is referenced by the
`swiftformat_pkg` that we will add to each of the Bazel packages that contain Swift source files.

The [updatesrc_update_all](https://github.com/cgrindel/bazel-starlib/blob/main/doc/updatesrc/rules_and_macros_overview.md#updatesrc_update_all)
macro defines a runnable target that copies all of the formatted Swift source files to the workspace
directory.


### 3. Add `swiftformat_pkg` to every Bazel package with Swift source files

In every Bazel package that contains Swift source files, add a
[`swiftformat_pkg`](/doc/rules_and_macros_overview.md#swiftformat_pkg) declaration.

```python
load(
    "@rules_swift_tidy//swiftformat:defs.bzl",
    "swiftformat_pkg",
)

swiftformat_pkg(name = "swiftformat")
```

The [`swiftformat_pkg`](/doc/rules_and_macros_overview.md#swiftformat_pkg) macro defines targets for
a Bazel package which will format the Swift source files, test that the formatted files are in the
workspace directory and copies the formatted files to the workspace directory.

### 4. Format, Update, and Test

From the command-line, you can format the Swift source files, copy them back to the workspace
directory and execute the tests that ensure the formatted soures are in the workspace directory.

```sh
# Format the Swift source files and copy the formatted files back to the workspace directory
$ bazel run //:update_all

# Execute all of your tests including the formatting checks
$ bazel test //...
```

## Specifying the SwiftFormat Version

By default, `rules_swift_tidy` will load a [recent release of
SwiftFormat](https://github.com/nicklockwood/SwiftFormat/releases). This works well for most cases.
However, if you would like to specify the SwiftFormat release, you can do so by declaring
`swiftformat` tags on the `swift_tidy_tools` extension in your `MODULE.bazel`. You must declare a
tag for each of the three supported platforms: `macos`/`x86_64`, `macos`/`arm64`, and
`linux`/`x86_64`. Declaring any tag replaces all of the defaults, so if a platform is missing, Bazel
fails with `does not generate repository "swiftformat_download_<os>_<cpu>"`.

To make this easier, this repository includes a tool called `generate_assets_declaration`. Executing
this tool will generate the appropriate declaration to download and configure the desired version of
SwiftFormat.

```sh
# Specify the desired SwiftFormat version
$ bazel run //tools:generate_assets_declaration -- "0.51.11"
swift_tidy_tools = use_extension(
    "@rules_swift_tidy//swifttidy:extensions.bzl",
    "swift_tidy_tools",
)
swift_tidy_tools.swiftformat(
    version = "0.51.11",
    os = "macos",
    cpu = "x86_64",
    sha256 = "e565ebf6c54ee8e1ac83e4974edae34e002f86eda358a5838c0171f32f00ab20",
)
swift_tidy_tools.swiftformat(
    version = "0.51.11",
    os = "macos",
    cpu = "arm64",
    sha256 = "e565ebf6c54ee8e1ac83e4974edae34e002f86eda358a5838c0171f32f00ab20",
)
swift_tidy_tools.swiftformat(
    version = "0.51.11",
    os = "linux",
    cpu = "x86_64",
    sha256 = "a49b79d97c234ccb5bcd2064ffec868e93e2eabf2d5de79974ca3802d8e389ec",
)
```

## Special Instructions for Linux Users

By default, this ruleset downloads prebuilt binaries from
[nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat). The Linux binaries provided
by this website dynamically load certain shared libraries (e.g. Foundation). On Linux, Swift
finds these libraries by searching the directories specified by the `LD_LIBRARY_PATH` envronment
variable.  Be sure to update this environment variable with the path to the shard libraries provided
by the Swift SDK.

For instance, on Ubuntu, one might install Swift to `$HOME/swift-5.7.2-RELEASE-ubuntu22.04`. The
shared library directory for this installation is 
`$HOME/swift-5.7.2-RELEASE-ubuntu22.04/usr/lib/swift/linux`.

In addition to setting the `LD_LIBRARY_PATH` environment variable, you must tell Bazel to provide
this value to its actions. This is done by using the `--action_env` flag. Update the `.bazelrc` file
for your project to include the following:

```
# Need to expose the PATH so that the Swift toolchain can be found
build --action_env=PATH

# Need to expose the LD_LIBRARY_PATH so that the Swift dynamic loaded 
# so files can be found
build --action_env=LD_LIBRARY_PATH
```

## Learn More

- [How It Works](/doc/how_it_works.md)
- [How to seamlessly build and format your Swift source
  code](/doc/integrate_with_rules_swift.md) using
[swiftformat_library](/doc/rules_and_macros_overview.md#swiftformat_library),
[swiftformat_binary](/doc/rules_and_macros_overview.md#swiftformat_binary), and
[swiftformat_test](/doc/rules_and_macros_overview.md#swiftformat_test). 
- Check out the [rest of the documentation](/doc)

