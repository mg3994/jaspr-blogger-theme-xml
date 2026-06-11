
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

String _escapeXml(String text) {
  return text
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');
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
