# How It Works - Format, Test, and Update

This document describes how `rules_swiftformat` works, helping you maintain your project's code
hygiene.

##  Capabilities

The rules and macros in this repository perform three distinct tasks:

1. Format Swift source files using [nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat);
2. Test that the sources in the workspace directory match the formatted sources; and
3. Copy the formatted source files to the workspace directory.

The following sections provide more detail on how these are implemented.

### Format

The `swiftformat_pkg` macro defines a build target for each Swift source file in its `srcs`
attribute. This build target creates a formatted version of the source file in the output directory.
Hence, whenever `bazel build` or `bazel test` are invoked, Bazel magic determines if the source file
has changed and executes the corresponding format build target. So, there are two important points
to note:

1. Only Swift source files that are new or have changed will be formatted.
2. The formatted source files only exist in the output directory after the build step.

### Test

The `swiftformat_pkg` macro defines a test target for each Swift source file in its `srcs`
attribute. The test target compares the output of the format build target mentioned above with the
actual source file. If the two files differ, the test fails. As you might expect, these targets are
exercised by running `bazel test`.

### Update/Copy to the Workspace Directory

Each Bazel package that has a `swiftformat_pkg` declaration contains a runnable target that, when
executed, copies the formatted source files for the Bazel package from the output directory to the
workspace/source directory.

For instance, if you defined your `swiftformat_pkg` with the name `swiftformat`, the runnable target
is called `swiftformat_update`. So, to update the files in a single package you would run:

```sh
$ bazel run //path/to/pkg:swiftformat_update
```

Since finding and running these commands manually would be tedious, we added a
`swiftformat_update_all` declaration at the root of the workspace. This will find all of the update
commands and run them.

```sh
$ bazel run //:update_all
```

## Putting It All Together

So, the typical development workflow goes something like this:

1. Make a code change.
2. Build and test: `bazel test //...`.
3. If a format test fails, copy the formatted files to your workspace: `bazel run //:update_all`.

If like most developers, you have integrated SwiftFormat into your IDE. There is a very good
chance that you will never need to perform the update step as your source code will already be
formatted. 

// TODO: Add link to the IDE integration article.

If you would like to leverage the SwiftFormat executable that is built for your project in your IDE
integration, check out this article on fashining a script that will smartly build and execute
SwiftFormat.
