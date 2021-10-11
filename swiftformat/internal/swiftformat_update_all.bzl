def swiftformat_update_all(name):
    native.sh_binary(
        name = name,
        srcs = [
            "@cgrindel_rules_swiftformat//scripts:update_all.sh",
        ],
    )
