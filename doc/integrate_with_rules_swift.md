# How to Integrate `rules_swiftformat` Into Your Project

You have decided to integrate Swift source code formatting into your project using
`rules_swiftformat`. Now, the question is what is the best way to do so.

## Options

### Option #1: Add `swiftformat_pkg` to each Bazel package

This is pretty straightforward. Either manually or using
[Buildozer](https://github.com/bazelbuild/buildtools/tree/master/buildozer), you can add the
[`swiftformat_pkg`](/doc/rules_and_macros_overview.md#swiftformat_pkg) macro to the Bazel packages
that contain Swift source files. This is the technique that is described in [the
quickstart](/README.md#quickstart) and [the simple example](/examples/simple). 

However, this option has one downside. There is no easy way to ensure that `swiftformat_pkg` is
added to any new Bazel packages that are created in the future.

### Option #2: Combine the build and format declarations

Wouldn't it be great if we could combine the build and format declarations into one declaration?
Yes, it would. Luckily, Bazel supports user-defined
[macros](https://docs.bazel.build/versions/main/skylark/macros.html). They allow us to combine
multiple declarations into a convenient and tidy declaration. 

After implementing `rules_swiftformat`, we began rolling it out to our other projects. We
immediately realized that we wanted to make it very simple to define a Swift build target and
formatting target. We assumed that other folks would want to do the same. So, we implemented 
[`swiftformat_library`](/doc/rules_and_macros_overview.md#swiftformat_library),
[`swiftformat_binary`](/doc/rules_and_macros_overview.md#swiftformat_binary), and
[`swiftformat_test`](/doc/rules_and_macros_overview.md#swiftformat_test). These macros define
the corresponding `swift_XXX` declaration and the appropriate `swiftformat_pkg` declaration.  This
technique is demonstrated in our [rules_swift_helpers example](/examples/rules_swift_helpers).

In short, the `swiftformat_XXX` macros take all of the same attributes as their `swift_XXX`
counterparts. In addition, they have two other attributes:
[`swiftformat_config`](/doc/rules_and_macros_overview.md#swiftformat_library-swiftformat_config) and
a [`swiftformat_name`](/doc/rules_and_macros_overview.md#swiftformat_library-swiftformat_name).
These can be used to customize the formatting for the package if desired.

The following shows a `BUILD.bazel` file that uses the
[`swiftformat_library`](/doc/rules_and_macros_overview.md#swiftformat_library) macro.

```python
load(
    "@cgrindel_rules_swiftformat//swiftformat:defs.bzl",
    "swiftformat_library",
)

swiftformat_library(
    name = "Foo",
    srcs = glob(["*.swift"]),
    module_name = "Foo",
    visibility = ["//:__subpackages__"],
)
```

### Option #3: Custom `swift_XXX` macros

Perhaps the idea of combining the build and formatting declarations sounds great to you. However,
you don't like the idea of introducing an unfamiliar declaration like `swiftformat_XXX`. Or, perhaps
you just want to consolidate your build declarations with some project-specific defaults. Well, you
may want to define your own `swift_library`, `swift_binary`, and `swift_test` macros.  We
use this technique in our [Swift Toolbox repository](https://github.com/cgrindel/swift_toolbox).

Create the `build/swift` directories at the root of your workspace and add a `BUILD.bazel` file.

```sh
$ mkdir -p build/swift
$ echo "# Intentionally blank" >> build/swift/BUILD.bazel
```

Now, create a `swift_library.bzl` file with the following contents:

```python
load(
    "@cgrindel_rules_swiftformat//swiftformat:defs.bzl",
    "swiftformat_library",
)

def swift_library(name, srcs = None, **kwargs):
    if srcs == None:
        srcs = native.glob(["*.swift"])

    swiftformat_library(
        name = name,
        srcs = srcs,
        **kwargs
    )
```

Next, create a `swift_test.bzl` file and a `swift_binary.bzl` file using the same template as above.
Be sure to change `_library` to the appropriate suffix.

Lastly, update the load statements for all of the Bazel build files that contain `swift_XXX`
declarations so that they load your macro instead of the original rule. Change
`load("@build_bazel_rules_swift//swift:swift.bzl", "swift_XXX") ` to
`load("//build/swift:swift_library.bzl", "swift_XXX")`.

Here is an example of an updated `BUILD.bazel` file.

```python
load("//build/swift:swift_library.bzl", "swift_library")

swift_library(
    name = "DateUtils",
    module_name = "DateUtils",
    visibility = ["//visibility:public"],
)
```


## Conclusion

As we have seen, there are several ways to integrate `rules_swiftformat` into your Bazel project.
All of them are valid. However, we would recommend using either Option #2 or Option #3 if you are
implementing this for a large repository or a repository that has multiple contributors. It is less
likely that new Bazel packages will be implemented without the desired formatting capabilities.
