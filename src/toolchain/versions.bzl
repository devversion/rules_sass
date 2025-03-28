PLATFORMS = {
    "linux_amd64": struct(
        compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ],
    ),
    "linux_arm64": struct(
        compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:arm64",
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
        "url": "https://github.com/sass/dart-sass/releases/download/1.86.0/dart-sass-1.86.0-linux-x64.tar.gz",
        "sha256": ""
    },
    "linux_arm64": {
        "url": "https://github.com/sass/dart-sass/releases/download/1.86.0/dart-sass-1.86.0-linux-arm64.tar.gz",
        "sha256": "",
    },
    "darwin_amd64": {
        "url": "https://github.com/sass/dart-sass/releases/download/1.86.0/dart-sass-1.86.0-macos-x64.tar.gz",
        "sha256": "",
    },
    "darwin_arm64": {
        "url": "https://github.com/sass/dart-sass/releases/download/1.86.0/dart-sass-1.86.0-macos-arm64.tar.gz",
        "sha256": "",
    }
}
