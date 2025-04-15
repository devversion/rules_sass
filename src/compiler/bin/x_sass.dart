import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sprintf/sprintf.dart';

import 'package:sass/src/executable/concurrent.dart';
import 'package:sass/src/executable/options.dart';
import 'package:sass_api/sass_api.dart';
import 'package:sass/src/stylesheet_graph.dart';

void main(List<String> arguments) async {
  try {
    var mappingsFile = arguments[0];
    var sassArgs = arguments.sublist(1);
    var opts = ExecutableOptions.parse(sassArgs);

    var graph = StylesheetGraph(
      ImportCache(
        importers: [
          new ModuleMappingImporter(await File(mappingsFile).readAsString()),
          FilesystemImporter.noLoadPath,
        ],
        loadPaths: opts.loadPaths,
      ),
    );

    if (!(await compileStylesheets(opts, graph, opts.sourcesToDestinations))) {
      exitCode = 1;
    }
  } on UsageException catch (error) {
    print("${error.message}\n");
    print(ExecutableOptions.usage);
    exitCode = 1;
  } catch (error, stackTrace) {
    print(error);
    print(stackTrace);
    exitCode = 1;
  }
}

final class ModuleMappingImporter extends Importer {
  Map<String, dynamic> mappings = new Map();
  List<String>? sortedMappings;

  ModuleMappingImporter(String mappingsFileContents) {
    this.mappings = jsonDecode(mappingsFileContents);
    this.sortedMappings =
        this.mappings.keys.toList()..sort((a, b) => a.length - b.length);
  }

  @override
  Uri? canonicalize(Uri url) {
    if (url.scheme == 'file') return null;

    final match = this.sortedMappings?.firstWhere(
      (m) => url.toString().startsWith(m),
    );
    final rest = match != null ? url.toString().substring(match.length) : null;
    final target = match != null ? this.mappings[match] as String? : null;

    if (match != null && rest != null && target != null) {
      url = Uri.file(p.absolute(p.normalize(sprintf("%s/%s", [target, rest]))));
    }

    return FilesystemImporter.noLoadPath.canonicalize(url);
  }

  ImporterResult? load(Uri url) => FilesystemImporter.noLoadPath.load(url);
  DateTime modificationTime(Uri url) =>
      FilesystemImporter.noLoadPath.modificationTime(url);
  bool couldCanonicalize(Uri url, Uri canonicalUrl) =>
      FilesystemImporter.noLoadPath.couldCanonicalize(url, canonicalUrl);
  bool isNonCanonicalScheme(String scheme) =>
      FilesystemImporter.noLoadPath.isNonCanonicalScheme(scheme);
}
