load("@rules_sass//src/toolchain:configure_sass.bzl", "configure_sass")
load("@rules_sass//src/toolchain:versions.bzl", "PLATFORMS", "VERSION")

def setup_rules_sass():
    for platform in PLATFORMS.keys():
        info = VERSION[platform]

        configure_sass(
            name = "%s_sass" % platform,
            file = info["file"],
            sha256 = info["sha256"],
            constraints = PLATFORMS[platform].compatible_with,
        )

        native.register_toolchains("@%s_sass//:toolchain" % platform)
