import 'dart:io';
import 'package:path/path.dart' as p;
import 'core.dart';
import 'html_components.dart';

class BClientScript extends Component {
  final String scriptPath;

  const BClientScript(this.scriptPath);

  @override
  Iterable<Component> build() {
    // This will be handled during the rendering process or by a pre-processor.
    // For simplicity, we can make it a DomComponent that we populate later.
    return [
      _CompiledScript(scriptPath)
    ];
  }
}

class _CompiledScript extends DomComponent {
  final String scriptPath;
  _CompiledScript(this.scriptPath) : super('script', attributes: {'type': 'text/javascript'});

  @override
  Iterable<Component> build() {
    var jsContent = _compileDartToJs(scriptPath);
    return [Text(jsContent)];
  }

  String _compileDartToJs(String path) {
    var fullPath = p.absolute(path);
    if (!File(fullPath).existsSync()) {
      return '// Error: Script not found at $fullPath';
    }

    var tempDir = Directory.systemTemp.createTempSync('dart_compile');
    var outFile = p.join(tempDir.path, 'out.js');

    try {
      var result = Process.runSync('dart', [
        'compile',
        'js',
        '-O4',
        fullPath,
        '-o',
        outFile,
      ]);

      if (result.exitCode != 0) {
        return '// Error compiling Dart to JS:\nExit code: ${result.exitCode}\nSTDOUT: ${result.stdout}\nSTDERR: ${result.stderr}';
      }

      return File(outFile).readAsStringSync();
    } finally {
      // tempDir.deleteSync(recursive: true); // Keep it for now if debugging
    }
  }
}
