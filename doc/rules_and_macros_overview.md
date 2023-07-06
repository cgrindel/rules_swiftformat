<!-- Generated with Stardoc, Do Not Edit! -->
# Rules and Macros

The rules and macros described below are used to tidy Swift source 
files.

On this page:

  * [swiftformat_format](#swiftformat_format)
  * [swiftformat_pkg](#swiftformat_pkg)
  * [swiftformat_register_prebuilt_toolchains](#swiftformat_register_prebuilt_toolchains)


<a id="swiftformat_format"></a>

## swiftformat_format

<pre>
swiftformat_format(<a href="#swiftformat_format-name">name</a>, <a href="#swiftformat_format-config">config</a>, <a href="#swiftformat_format-output_suffix">output_suffix</a>, <a href="#swiftformat_format-srcs">srcs</a>, <a href="#swiftformat_format-swift_version">swift_version</a>)
</pre>

Formats the Swift source files using `nicklockwood/SwiftFormat`.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="swiftformat_format-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="swiftformat_format-config"></a>config |  A swiftformat config file.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="swiftformat_format-output_suffix"></a>output_suffix |  The suffix to add to the output filename.   | String | optional | <code>"_formatted"</code> |
| <a id="swiftformat_format-srcs"></a>srcs |  The Swift source files to format.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |
| <a id="swiftformat_format-swift_version"></a>swift_version |  The Swift version to be used by <code>swiftformat</code>. You probably want to add this to your config file instead of adding it here.   | String | optional | <code>""</code> |


<a id="swiftformat_pkg"></a>

## swiftformat_pkg

<pre>
swiftformat_pkg(<a href="#swiftformat_pkg-name">name</a>, <a href="#swiftformat_pkg-srcs">srcs</a>, <a href="#swiftformat_pkg-config">config</a>)
</pre>

Defines targets that will format, test and update the specified Swift sources.

NOTE: Any labels detected in the `srcs` will be ignored.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_pkg-name"></a>name |  The base name for the targets that will be defined.   |  none |
| <a id="swiftformat_pkg-srcs"></a>srcs |  Optional. The Swift source files that should be formatted.   |  <code>None</code> |
| <a id="swiftformat_pkg-config"></a>config |  Optional. The swiftformat YAML configuration file.   |  <code>None</code> |


<a id="swiftformat_register_prebuilt_toolchains"></a>

## swiftformat_register_prebuilt_toolchains

<pre>
swiftformat_register_prebuilt_toolchains(<a href="#swiftformat_register_prebuilt_toolchains-name">name</a>, <a href="#swiftformat_register_prebuilt_toolchains-swiftformat_assets">swiftformat_assets</a>, <a href="#swiftformat_register_prebuilt_toolchains-register_toolchains">register_toolchains</a>)
</pre>

Register and configure the toolchains to download pre-built SwiftFormat     binaries.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_register_prebuilt_toolchains-name"></a>name |  Optional. The name for the toolchains repository as a <code>string</code>.   |  <code>"swift_tidy_prebuilt_toolchains"</code> |
| <a id="swiftformat_register_prebuilt_toolchains-swiftformat_assets"></a>swiftformat_assets |  Optional. A <code>list</code> of tools to register. If not specified, it uses a recent version of SwiftFormat.   |  <code>None</code> |
| <a id="swiftformat_register_prebuilt_toolchains-register_toolchains"></a>register_toolchains |  Optional. A <code>bool</code> that determines whether this function should call <code>register_toolchains()</code>.   |  <code>True</code> |


