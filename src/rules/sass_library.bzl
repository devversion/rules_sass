"""The `sass_library` rule for grouping and exposing Sass files for compilations."""

load("@rules_sass//src/shared:collect_transitive.bzl", "collect_transitive_sources")
load("@rules_sass//src/shared:extensions.bzl", "ALLOWED_SRC_FILE_EXTENSIONS")
load("@rules_sass//src/shared:providers.bzl", "SassInfo")

def _sass_library_impl(ctx):
    """sass_library collects all transitive sources for given srcs and deps."""
    transitive_sources = collect_transitive_sources(
        ctx.files.srcs,
        ctx.attr.deps,
    )
    return [
        SassInfo(transitive_sources = transitive_sources),
        DefaultInfo(
            files = transitive_sources,
            runfiles = ctx.runfiles(transitive_files = transitive_sources),
        ),
    ]

sass_library = rule(
    implementation = _sass_library_impl,
    attrs = {
        "srcs": attr.label_list(
            doc = "Sass source files",
            allow_files = ALLOWED_SRC_FILE_EXTENSIONS,
            allow_empty = False,
            mandatory = True,
        ),
        "deps": attr.label_list(
            doc = "sass_library targets to include in the compilation",
            providers = [SassInfo],
            allow_files = False,
        ),
    },
)
