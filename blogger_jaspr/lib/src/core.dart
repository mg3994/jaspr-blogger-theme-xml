
abstract class Component {
  const Component();
  Iterable<dynamic> build();
}

class Text extends Component {
  final String value;
  final bool escape;
  const Text(this.value, {this.escape = true});

  @override
  Iterable<dynamic> build() => [];
}

class RawText extends Text {
  const RawText(String value) : super(value, escape: false);
}

class DomComponent extends Component {
  final String tag;
  final Map<String, String>? attributes;
  final Iterable<dynamic>? children;

  const DomComponent(this.tag, {this.attributes, this.children});

  @override
  Iterable<dynamic> build() => children ?? [];
}

class Fragment extends Component {
  final Iterable<dynamic> children;
  const Fragment({required this.children});

  @override
  Iterable<dynamic> build() => children;
}

String _escapeXml(String text, {String? quoteToEscape, bool escapeAllQuotes = false}) {
  var sb = StringBuffer();
  for (var i = 0; i < text.length; i++) {
    var char = text[i];
    var code = char.codeUnitAt(0);

    // Escape basic XML characters
    if (char == '&') {
      sb.write('&amp;');
    } else if (char == '<') {
      sb.write('&lt;');
    } else if (char == '>') {
      sb.write('&gt;');
    } else if (char == '"') {
      if (escapeAllQuotes || quoteToEscape == '"') {
        sb.write('&quot;');
      } else {
        sb.write('"');
      }
    } else if (char == "'") {
      if (escapeAllQuotes || quoteToEscape == "'") {
        sb.write('&apos;');
      } else {
        sb.write("'");
      }
    }
    // XML 1.0 restricted control characters (0x00 to 0x1F except 0x09, 0x0A, 0x0D)
    else if ((code >= 0x00 && code <= 0x08) ||
        (code >= 0x0B && code <= 0x0C) ||
        (code >= 0x0E && code <= 0x1F)) {
      // Replace with a space or just skip. For JS, replacing with space is safer.
      sb.write(' ');
    }
    // Handle non-printable or potentially problematic characters by hex encoding if needed
    // but for now, the above covers the critical XML requirements.
    else {
      sb.write(char);
    }
  }
  return sb.toString();
}

class Renderer {
  String render(Component component) {
    var sb = StringBuffer();
    _renderComponent(component, sb);
    return sb.toString();
  }

  void _renderComponent(dynamic node, StringBuffer sb) {
    if (node == null) return;
    if (node is String) {
      sb.write(_escapeXml(node, escapeAllQuotes: true));
    } else if (node is Text) {
      sb.write(node.escape ? _escapeXml(node.value, escapeAllQuotes: true) : node.value);
    } else if (node is DomComponent) {
      sb.write('<${node.tag}');
      if (node.attributes != null) {
        for (var entry in node.attributes!.entries) {
          var value = entry.value;
          var useSingleQuote = value.contains('"') && !value.contains("'");
          var quote = useSingleQuote ? "'" : '"';
          sb.write(' ${entry.key}=$quote${_escapeXml(value, quoteToEscape: quote)}$quote');
        }
      }

      var children = node.build();
      if (children.isEmpty) {
        sb.write('/>');
      } else {
        sb.write('>');
        for (var child in children) {
          _renderComponent(child, sb);
        }
        sb.write('</${node.tag}>');
      }
    } else if (node is Component) {
      for (var child in node.build()) {
        _renderComponent(child, sb);
      }
    } else if (node is Iterable) {
      for (var child in node) {
        _renderComponent(child, sb);
      }
    }
  }
}

extension StringAsComponent on String {
  Component get component => Text(this);
}
