SwiftFormatInfo = provider(
    doc = "Information about the files that were formatted.",
    fields = {
        "format_map": """\
A `dict` where the key is the original source `File` and the value is the\
formatted `File`.\
""",
    },
)

# def _format_map(src, out):
#     return struct(
#         src = src,
#         out = out,
#     )

# providers = struct(
#     format_map = _format_map,
# )
