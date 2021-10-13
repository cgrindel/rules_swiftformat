# SwiftFormat Rules for Bazel

[![Build](https://github.com/cgrindel/rules_swiftformat/actions/workflows/bazel.yml/badge.svg)](https://github.com/cgrindel/rules_swiftformat/actions/workflows/bazel.yml)

This repository contains Bazel rules and macros that will format Swift source files using
[nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat), test that the formatted
files exist in the workspace directory, and copy the formatted files to the workspace directory.


<a id="#quickstart"></a>
## Quickstart

### 1. Configure your workspace to use `rules_swiftformat`

Add the following to your `WORKSPACE` file to add this repository and its dependencies.

```python

# Download and configure rules_swiftformat.

# GH008 Update this section once release 0.1.0 is available.
local_repository(
    name = "cgrindel_rules_swiftformat",
    path = "../..",
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

# We are using rules_spm to download and build SwiftFormat. The following will define configure
# rules_spm to do that.

load("@cgrindel_rules_swiftformat//swiftformat:load_package.bzl", "swiftformat_load_package")

swiftformat_load_package()
```

### 2. Update the `BUILD.bazel` at the root of your workspace

At the root of your workspace, create a `BUILD.bazel` file, if you don't have one. Then, define a
target for your SwiftFormat configuration file (`.swiftformat`). 

```python
# We export this file to make it available to other Bazel packages in the workspace.
exports_files([".swiftformat"])
```

Next, add the following to define a runnable Bazel target that will copy all of the formatted Swift
source files to your workspace directory.

```python
# Defines a target that will copy all of the formatted Swift source files to
# the workspace directory.
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
swiftformat_pkg(
    name = "format",
    config = "//:.swiftformat",
)
```

The `swiftformat_pkg` macro defines targets for this package which will format the Swift source
files, test that the formatted files are in the workspace directory and copies the formatted files
to the workspace directory.

## How it works - Format, Test, and Update

### Format

The Swift source files will be formatted whenever `bazel build` or `bazel test` are invoked in a
package that has a `swiftformat_pkg` declaration.  However, the formatted files are not copied to
the workspace directory at this point. They only exist in Bazel's output directories.

### Test

The tests that `rules_swiftformat` defines will compare the formatted files in the output directory
to the files in the workspace/source directory. If they do not match, the test fails.

### Update

Each Bazel package that has a `swiftformat_pkg` declaration will contain runnable target that will
copy the formatted source file from the output directory to the workspace/source directory.

For instance, if you defined your `swiftformat_pkg` with the name `format`, the runnable target is
called `format_update`. So, to update the files in a single package you would run:

```sh
$ bazel run //path/to/pkg:format_update
```

Since finding and running these commands manually would be tedious, we added a
`swiftformat_update_all` declaration at the root of the workspace. This will find all of the update
commands and run them.

```sh
$ bazel run //:update_all
```

