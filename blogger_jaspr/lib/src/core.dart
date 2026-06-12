
abstract class Component {
  const Component();
  Iterable<Component> build();
}

class Text extends Component {
  final String value;
  final bool escape;
  const Text(this.value, {this.escape = true});

  @override
  Iterable<Component> build() => [];
}

class RawText extends Text {
  const RawText(String value) : super(value, escape: false);
}

class DomComponent extends Component {
  final String tag;
  final Map<String, String>? attributes;
  final Iterable<Component>? children;

  const DomComponent(this.tag, {this.attributes, this.children});

  @override
  Iterable<Component> build() => children ?? [];
}

class Fragment extends Component {
  final Iterable<Component> children;
  const Fragment({required this.children});

  @override
  Iterable<Component> build() => children;
}

String _escapeXml(String text) {
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
      sb.write('&quot;');
    } else if (char == "'") {
      sb.write('&apos;');
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

  void _renderComponent(Component component, StringBuffer sb) {
    if (component is Text) {
      sb.write(component.escape ? _escapeXml(component.value) : component.value);
    } else if (component is DomComponent) {
      sb.write('<${component.tag}');
      if (component.attributes != null) {
        for (var entry in component.attributes!.entries) {
          sb.write(' ${entry.key}="${_escapeXml(entry.value)}"');
        }
      }

      var children = component.build();
      if (children.isEmpty) {
        sb.write('/>');
      } else {
        sb.write('>');
        for (var child in children) {
          _renderComponent(child, sb);
        }
        sb.write('</${component.tag}>');
      }
    } else {
      for (var child in component.build()) {
        _renderComponent(child, sb);
      }
    }
  }
}
