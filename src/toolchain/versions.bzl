PLATFORMS = {
    "linux_amd64": struct(
        compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ],
    ),
    "darwin_amd64": struct(
        compatible_with = [
            "@platforms//os:macos",
            "@platforms//cpu:x86_64",
        ],
    ),
    "darwin_arm64": struct(
        compatible_with = [
            "@platforms//os:macos",
            "@platforms//cpu:arm64",
        ],
    ),
}

VERSION = {
    "linux_amd64": {
        "file": "@rules_sass//src/compiler/dist:x_sass_linux_x64",
        "sha256": "",
    },
    "darwin_amd64": {
        "file": "@rules_sass//src/compiler/dist:x_sass_mac_x64",
        "sha256": "",
    },
    "darwin_arm64": {
        "file": "@rules_sass//src/compiler/dist:x_sass_linux_arm",
        "sha256": "",
    },
}
