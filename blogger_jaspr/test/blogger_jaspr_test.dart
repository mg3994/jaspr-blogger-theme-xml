import 'package:test/test.dart';
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  group('Core Rendering', () {
    test('renders basic tags', () {
      var renderer = Renderer();
      var component = Div(children: [Text('Hello')]);
      expect(renderer.render(component), equals('<div>Hello</div>'));
    });

    test('escapes special characters in text', () {
      var renderer = Renderer();
      var component = Text('<a> & "b"');
      expect(renderer.render(component), equals('&lt;a&gt; &amp; &quot;b&quot;'));
    });

    test('renders self-closing tags', () {
      var renderer = Renderer();
      var component = BData(value: 'blog.title');
      expect(renderer.render(component), equals('<data:blog.title/>'));
    });
  });

  group('Blogger Components', () {
    test('renders BIf with condition', () {
      var renderer = Renderer();
      var component = BIf(cond: 'data:view.isPost', children: [Text('Post')]);
      expect(renderer.render(component), equals('<b:if cond="data:view.isPost">Post</b:if>'));
    });

    test('renders BSkin with CDATA', () {
      var renderer = Renderer();
      var component = BSkin('body { color: red; }');
      expect(renderer.render(component), contains('<![CDATA[\nbody { color: red; }\n]]>'));
    });
  });
}
