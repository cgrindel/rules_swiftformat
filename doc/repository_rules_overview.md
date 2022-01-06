<!-- Generated with Stardoc, Do Not Edit! -->
# Repository Rules and Macros

The rules and macros described below are used to configure and download 
dependencies for rules_swiftformat.

On this page:

  * [swiftformat_load_package](#swiftformat_load_package)


<a id="#swiftformat_load_package"></a>

## swiftformat_load_package

<pre>
swiftformat_load_package(<a href="#swiftformat_load_package-version">version</a>)
</pre>

Loads SwiftFormat using Swift Package Manager via `rules_spm`.

If a version is not specified, Swift Package Manager will be configured to     load the latest release.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_load_package-version"></a>version |  Optional. A valid semver <code>string</code> for SwiftFormat.   |  <code>None</code> |


