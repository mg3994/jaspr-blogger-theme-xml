import 'core.dart';
import 'html_components.dart';

class BloggerTheme extends Component {
  final Iterable<dynamic> head;
  final Iterable<dynamic> body;
  final Map<String, String>? attributes;

  const BloggerTheme({
    required this.head,
    required this.body,
    this.attributes,
  });

  @override
  Iterable<Component> build() {
    return [
      Html(
        attributes: attributes,
        children: [
          Head(children: head),
          Body(children: body),
        ],
      )
    ];
  }

  String generate() {
    var renderer = Renderer();
    return '<?xml version="1.0" encoding="UTF-8" ?>\n'
        '${renderer.render(this)}';
  }
}
