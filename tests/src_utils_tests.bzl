load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")

def _is_label_test(ctx):
    env = unittest.begin(ctx)

    unittest.fail(env, "IMPLEMENT ME!")

    return unittest.end(env)

is_label_test = unittest.make(_is_label_test)

def _is_path_test(ctx):
    env = unittest.begin(ctx)

    unittest.fail(env, "IMPLEMENT ME!")

    return unittest.end(env)

is_path_test = unittest.make(_is_path_test)

def src_utils_test_suite():
    return unittest.suite(
        "src_utils_tests",
        is_label_test,
        is_path_test,
    )
