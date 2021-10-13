<!-- Generated with Stardoc, Do Not Edit! -->
# Rules and Macros

The rules and macros described below are used to format, test and 
copy Swift source files.

On this page:

  * [swiftformat_format](#swiftformat_format)
  * [swiftformat_pkg](#swiftformat_pkg)
  * [swiftformat_update](#swiftformat_update)
  * [swiftformat_update_all](#swiftformat_update_all)


<a id="#swiftformat_format"></a>

## swiftformat_format

<pre>
swiftformat_format(<a href="#swiftformat_format-name">name</a>, <a href="#swiftformat_format-config">config</a>, <a href="#swiftformat_format-output_suffix">output_suffix</a>, <a href="#swiftformat_format-srcs">srcs</a>, <a href="#swiftformat_format-swift_version">swift_version</a>)
</pre>

Formats the Swift source files using `nicklockwood/SwiftFormat`.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="swiftformat_format-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="swiftformat_format-config"></a>config |  A swiftformat config file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="swiftformat_format-output_suffix"></a>output_suffix |  The suffix to add to the output filename.   | String | optional | "_formatted" |
| <a id="swiftformat_format-srcs"></a>srcs |  The Swift source files to format.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| <a id="swiftformat_format-swift_version"></a>swift_version |  The Swift version to be used by <code>swiftformat</code>. You probably want to add this to your config file instead of adding it here.   | String | optional | "" |


<a id="#swiftformat_update"></a>

## swiftformat_update

<pre>
swiftformat_update(<a href="#swiftformat_update-name">name</a>, <a href="#swiftformat_update-formats">formats</a>)
</pre>

Copies the formatted Swift sources to the workspace directory.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="swiftformat_update-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="swiftformat_update-formats"></a>formats |  The format build targets.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


<a id="#swiftformat_pkg"></a>

## swiftformat_pkg

<pre>
swiftformat_pkg(<a href="#swiftformat_pkg-name">name</a>, <a href="#swiftformat_pkg-srcs">srcs</a>, <a href="#swiftformat_pkg-config">config</a>)
</pre>

Defines targets that will format, test and update the specified Swift sources.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_pkg-name"></a>name |  The base name for the targets that will be defined.   |  none |
| <a id="swiftformat_pkg-srcs"></a>srcs |  Optional. The Swift source files that should be formatted.   |  <code>None</code> |
| <a id="swiftformat_pkg-config"></a>config |  Optional. The swiftformat YAML configuration file.   |  <code>None</code> |


<a id="#swiftformat_update_all"></a>

## swiftformat_update_all

<pre>
swiftformat_update_all(<a href="#swiftformat_update_all-name">name</a>)
</pre>

Defines a runnable target that will copy the formatted Swift files to the source tree.

The utility queries for all of the swiftformat_update rules in the
workspace and executes each one. Hence, only Swift source files that are
referenced by a swiftformat_update will be copied to the workspace
directory.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_update_all-name"></a>name |  The name of the target.   |  none |


