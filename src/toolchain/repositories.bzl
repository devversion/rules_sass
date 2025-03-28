load("@rules_sass//src/toolchain:download_sass.bzl", "download_sass")
load("@rules_sass//src/toolchain:versions.bzl", "PLATFORMS", "VERSION")

def setup_rules_sass():
    for platform in PLATFORMS.keys():
        info = VERSION[platform]

        download_sass(
            name = "%s_sass_download" % platform,
            url = info["url"],
            sha256 = info["sha256"],
            constraints = PLATFORMS[platform].compatible_with,
        )

        native.register_toolchains("@%s_sass_download//:toolchain" % platform)
