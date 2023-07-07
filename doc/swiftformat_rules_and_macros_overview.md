<!-- Generated with Stardoc, Do Not Edit! -->
# Deprecated Rules and Macros

The rules and macros described below are used to format, test and 
copy Swift source files.

On this page:

  * [swiftformat_binary](#swiftformat_binary)
  * [swiftformat_library](#swiftformat_library)
  * [swiftformat_test](#swiftformat_test)


<a id="swiftformat_binary"></a>

## swiftformat_binary

<pre>
swiftformat_binary(<a href="#swiftformat_binary-name">name</a>, <a href="#swiftformat_binary-swiftformat_config">swiftformat_config</a>, <a href="#swiftformat_binary-swiftformat_exclude">swiftformat_exclude</a>, <a href="#swiftformat_binary-srcs">srcs</a>, <a href="#swiftformat_binary-kwargs">kwargs</a>)
</pre>

Defines a `swift_binary` along with a `swiftformat_pkg`.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_binary-name"></a>name |  The name for the swift_binary as a <code>string</code>.   |  none |
| <a id="swiftformat_binary-swiftformat_config"></a>swiftformat_config |  A <code>label</code> for the SwiftFormat config file.   |  <code>None</code> |
| <a id="swiftformat_binary-swiftformat_exclude"></a>swiftformat_exclude |  A <code>list</code> of files or glob patterns that should be ignored for formatting.   |  <code>[]</code> |
| <a id="swiftformat_binary-srcs"></a>srcs |  The Swift sources that should be used by the <code>swift_binary</code> and the <code>swiftformat_pkg</code>.   |  <code>None</code> |
| <a id="swiftformat_binary-kwargs"></a>kwargs |  The attributes for <code>swift_binary</code>.   |  none |

**RETURNS**

None.


<a id="swiftformat_library"></a>

## swiftformat_library

<pre>
swiftformat_library(<a href="#swiftformat_library-name">name</a>, <a href="#swiftformat_library-swiftformat_config">swiftformat_config</a>, <a href="#swiftformat_library-swiftformat_exclude">swiftformat_exclude</a>, <a href="#swiftformat_library-srcs">srcs</a>, <a href="#swiftformat_library-kwargs">kwargs</a>)
</pre>

Defines a `swift_library` along with a `swiftformat_pkg`.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_library-name"></a>name |  The name for the swift_library as a <code>string</code>.   |  none |
| <a id="swiftformat_library-swiftformat_config"></a>swiftformat_config |  A <code>label</code> for the SwiftFormat config file.   |  <code>None</code> |
| <a id="swiftformat_library-swiftformat_exclude"></a>swiftformat_exclude |  A <code>list</code> of files or glob patterns that should be ignored for formatting.   |  <code>[]</code> |
| <a id="swiftformat_library-srcs"></a>srcs |  The Swift sources that should be used by the <code>swift_library</code> and the <code>swiftformat_pkg</code>.   |  <code>None</code> |
| <a id="swiftformat_library-kwargs"></a>kwargs |  The attributes for <code>swift_library</code>.   |  none |

**RETURNS**

None.


<a id="swiftformat_test"></a>

## swiftformat_test

<pre>
swiftformat_test(<a href="#swiftformat_test-name">name</a>, <a href="#swiftformat_test-swiftformat_config">swiftformat_config</a>, <a href="#swiftformat_test-swiftformat_exclude">swiftformat_exclude</a>, <a href="#swiftformat_test-srcs">srcs</a>, <a href="#swiftformat_test-kwargs">kwargs</a>)
</pre>

Defines a `swift_test` along with a `swiftformat_pkg`.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="swiftformat_test-name"></a>name |  The name for the swift_test as a <code>string</code>.   |  none |
| <a id="swiftformat_test-swiftformat_config"></a>swiftformat_config |  A <code>label</code> for the SwiftFormat config file.   |  <code>None</code> |
| <a id="swiftformat_test-swiftformat_exclude"></a>swiftformat_exclude |  A <code>list</code> of files or glob patterns that should be ignored for formatting.   |  <code>[]</code> |
| <a id="swiftformat_test-srcs"></a>srcs |  The Swift sources that should be used by the <code>swift_test</code> and the <code>swiftformat_pkg</code>.   |  <code>None</code> |
| <a id="swiftformat_test-kwargs"></a>kwargs |  The attributes for <code>swift_test</code>.   |  none |

**RETURNS**

None.


