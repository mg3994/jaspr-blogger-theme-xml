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

  group('XML Escaping', () {
    test('escapes control characters', () {
      var renderer = Renderer();
      var component = Text('Hello\x00World');
      expect(renderer.render(component), equals('Hello World'));
    });

    test('escapes all basic entities', () {
      var renderer = Renderer();
      var component = Text('< & > " \'');
      expect(renderer.render(component), equals('&lt; &amp; &gt; &quot; &apos;'));
    });
  });

  group('Attribute Quoting', () {
    test('uses single quotes when value contains double quotes', () {
      var renderer = Renderer();
      var component = DomComponent('link', attributes: {
        'expr:href': 'data:blog.homepageUrl.canonical path "search"'
      });
      expect(renderer.render(component), equals('<link expr:href=\'data:blog.homepageUrl.canonical path "search"\'/>'));
    });

    test('uses double quotes when value contains single quotes', () {
      var renderer = Renderer();
      var component = DomComponent('div', attributes: {
        'attr': "value with 'single' quote"
      });
      expect(renderer.render(component), equals('<div attr="value with \'single\' quote"/>'));
    });
  });

  group('Script CDATA', () {
    test('Script with contentInCDATA does not escape symbols', () {
      var renderer = Renderer();
      var component = Script(content: 'if (a && b) {}', contentInCDATA: true);
      var xml = renderer.render(component);
      expect(xml, contains('//<![CDATA['));
      expect(xml, contains('a && b'));
      expect(xml, isNot(contains('&amp;&amp;')));
    });
  });

  group('New HTML Tags', () {
    test('renders Span correctly', () {
      var renderer = Renderer();
      var component = Span(children: [Text('Hello')]);
      expect(renderer.render(component), equals('<span>Hello</span>'));
    });

    test('renders H1 correctly', () {
      var renderer = Renderer();
      var component = H1(children: [Text('Title')]);
      expect(renderer.render(component), equals('<h1>Title</h1>'));
    });
  });

  group('Widget Settings', () {
    test('renders BWidgetSettings and BWidgetSetting', () {
      var renderer = Renderer();
      var component = BWidgetSettings(children: [
        BWidgetSetting(name: 'test-name', children: ['test-value'])
      ]);
      expect(renderer.render(component),
        equals('<b:widget-settings><b:widget-setting name="test-name">test-value</b:widget-setting></b:widget-settings>'));
    });
  });

  group('SVG Components', () {
    test('renders Svg with common attributes', () {
      var renderer = Renderer();
      var component = Svg(
        viewBox: '0 0 24 24',
        width: '18',
        children: [
          Path(d: 'M1 1h1v1H1z', fill: 'red')
        ],
      );
      var xml = renderer.render(component);
      expect(xml, contains('<svg viewBox="0 0 24 24" width="18">'));
      expect(xml, contains('<path d="M1 1h1v1H1z" fill="red"/>'));
      expect(xml, contains('</svg>'));
    });
  });
}
