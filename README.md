# SwiftFormat Rules for Bazel

[![Build](https://github.com/cgrindel/rules_swiftformat/actions/workflows/bazel.yml/badge.svg)](https://github.com/cgrindel/rules_swiftformat/actions/workflows/bazel.yml)

This repository contains Bazel rules and macros that will format Swift source files using
[nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat), test that the formatted
files exist in the workspace directory, and copy the formatted files to the workspace directory.

## Reference Documentation

[Click here](/doc) for reference documentation for the rules and other definitions in this
repository.

<a id="#quickstart"></a>
## Quickstart

The following provides a quick introduction on how to use the rules in this repository. Also, check
out the [examples directory](examples/) for more information.

### 1. Configure your workspace to use `rules_swiftformat`

Add the following to your `WORKSPACE` file to add this repository and its dependencies.

```python

# Download and configure rules_swiftformat.

http_archive(
    name = "cgrindel_rules_swiftformat",
    sha256 = "4942ca4f8f88d926964c7ff9c449c5c7eb2e0f1059675d16f75ea57bfdebb504",
    strip_prefix = "rules_swiftformat-0.1.0",
    urls = ["https://github.com/cgrindel/rules_swiftformat/archive/v0.1.0.tar.gz"],
)

load("@cgrindel_rules_swiftformat//swiftformat:deps.bzl", "swiftformat_rules_dependencies")

swiftformat_rules_dependencies()

# Configure the dependencies for rules_swiftformat

load(
    "@cgrindel_rules_spm//spm:deps.bzl",
    "spm_rules_dependencies",
)

spm_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:extras.bzl",
    "swift_rules_extra_dependencies",
)

swift_rules_extra_dependencies()

# We are using rules_spm to download and build SwiftFormat. The following will configure
# rules_spm to do that.

load("@cgrindel_rules_swiftformat//swiftformat:load_package.bzl", "swiftformat_load_package")

swiftformat_load_package()
```

### 2. Update the `BUILD.bazel` at the root of your workspace

At the root of your workspace, create a `BUILD.bazel` file, if you don't have one. Add the following
load statement.

```python
load(
    "@cgrindel_rules_swiftformat//swiftformat:swiftformat.bzl",
    "swiftformat_update_all",
)
```

Define a target for your [SwiftFormat configuration file
(`.swiftformat`)](https://github.com/nicklockwood/SwiftFormat#config-file). 

```python
# We export this file to make it available to other Bazel packages in the workspace.
exports_files([".swiftformat"])
```

Next, add the following:

```python
swiftformat_update_all(
    name = "update_all",
)
```

The [`swiftformat_update_all`](/doc/rules_and_macros_overview.md#swiftformat_update_all) macro will
define a runnable target that will copy all of the formatted Swift source files to the workspace
directory.


### 3. Add `swiftformat_pkg` to every Bazel package with Swift source files

In every Bazel package that contains Swift source files, add a
[`swiftformat_pkg`](/doc/rules_and_macros_overview.md#swiftformat_pkg) declaration.

```python
load(
    "@cgrindel_rules_swiftformat//swiftformat:swiftformat.bzl",
    "swiftformat_pkg",
)

swiftformat_pkg(
    name = "swiftformat",
)
```

The `swiftformat_pkg` macro defines targets for a Bazel package which will format the Swift source
files, test that the formatted files are in the workspace directory and copies the formatted files
to the workspace directory.

### 4. Format, Copy, and Test

From the command-line, you can format the Swift source files, copy them back to the workspace
directory and execute the tests that ensure the formatted soures are in the workspace directory.

```sh
# Format the Swift source files and copy the formatted files back to the workspace directory
$ bazel run //:update_all

# Execute all of your tests including the formatting checks
$ bazel test //...
```

## Learn More

- [How It Works](/doc/how_it_works.md)
- [Learn how to seamlessly build and format your Swift source
  code](/doc/build_and_format_swift_source_code.md) using swiftformat_library, swiftformat_binary,
swiftformat_test. 


