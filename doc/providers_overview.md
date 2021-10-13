<!-- Generated with Stardoc, Do Not Edit! -->
# Providers

The providers described below are used by [the rules](/doc/rules_and_macros_overview.md) to
pass along information about the source files and the formatted files.

On this page:

  * [SwiftFormatInfo](#SwiftFormatInfo)


<a id="#SwiftFormatInfo"></a>

## SwiftFormatInfo

<pre>
SwiftFormatInfo(<a href="#SwiftFormatInfo-format_map">format_map</a>)
</pre>

Information about the files that were formatted.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="SwiftFormatInfo-format_map"></a>format_map |  A <code>dict</code> where the key is the original source <code>File</code> and the value is the formatted <code>File</code>.    |


