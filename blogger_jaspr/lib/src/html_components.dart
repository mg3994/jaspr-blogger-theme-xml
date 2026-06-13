import 'core.dart';

class Html extends DomComponent {
  static const Map<String, String> _defaultAttributes = {
    // if they are not specified we will default to these values for better compatibility
    // with Blogger's template requirements shown below, but they can be overridden if needed
    'b:css': 'false',
    'b:defaultwidgetversion': '2',
    'b:layoutsversion': '3',
    'b:responsive': 'true',
    'expr:dir': 'data:blog.languageDirection',
    'expr:lang': 'data:blog.locale',
    // below are the standard XML namespaces for Blogger templates and they are fixed
    'xmlns': 'http://www.w3.org/1999/xhtml',
    'xmlns:b': 'http://www.google.com/2005/gml/b',
    'xmlns:data': 'http://www.google.com/2005/gml/data',
    'xmlns:expr': 'http://www.google.com/2005/gml/expr',
  };

  Html({Map<String, String?>? attributes, Iterable<Component>? children})
      : super(
          'html',
          attributes: _mergeAttributes(attributes),
          children: children,
        );

  static Map<String, String> _mergeAttributes(
    Map<String, String?>? attributes,
  ) {
    final merged = <String, String>{};
    if (attributes != null) {
      for (final entry in attributes.entries) {
        if (entry.value != null) {
          merged[entry.key] = entry.value!;
        }
      }
    }
    for (final entry in _defaultAttributes.entries) {
      merged.putIfAbsent(entry.key, () => entry.value);
    }
    return merged;
  }
}

class Head extends DomComponent {
  Head({Iterable<Component>? children}) : super('head', children: children);
}

class Body extends DomComponent {
  Body({Iterable<Component>? children}) : super('body', children: children);
}

class Title extends DomComponent {
  Title({Iterable<Component>? children}) : super('title', children: children);
}

class Meta extends DomComponent {
  Meta({Map<String, String>? attributes}) : super('meta', attributes: attributes);

  @override
  Iterable<Component> build() => [];
}

class Link extends DomComponent {
  Link({Map<String, String>? attributes}) : super('link', attributes: attributes);

  @override
  Iterable<Component> build() => [];
}

class Base extends DomComponent {
  Base({Map<String, String>? attributes}) : super('base', attributes: attributes);

  @override
  Iterable<Component> build() => [];
}

class Div extends DomComponent {
  Div({Map<String, String>? attributes, Iterable<Component>? children})
      : super('div', attributes: attributes, children: children);
}

class Form extends DomComponent {
  Form({Map<String, String>? attributes, Iterable<Component>? children})
      : super('form', attributes: attributes, children: children);
}

class Input extends DomComponent {
  Input({Map<String, String>? attributes})
      : super('input', attributes: attributes);

  @override
  Iterable<Component> build() => [];
}

class Button extends DomComponent {
  Button({Map<String, String>? attributes, Iterable<Component>? children})
      : super('button', attributes: attributes, children: children);
}

class Img extends DomComponent {
  Img({Map<String, String>? attributes}) : super('img', attributes: attributes);

  @override
  Iterable<Component> build() => [];
}

class Br extends DomComponent {
  Br() : super('br');

  @override
  Iterable<Component> build() => [];
}

class Hr extends DomComponent {
  Hr() : super('hr');

  @override
  Iterable<Component> build() => [];
}

class Script extends DomComponent {
  Script({
    String? src,
    String? type,
    String? content,
    bool? contentInCDATA,
    Iterable<Component>? children,
  }) : super('script',
            attributes: {
              if (src != null) 'src': src,
              if (type != null) 'type': type,
            },
            children: children ??
                (content != null
                    ? [
                        if (contentInCDATA == true)
                          RawText('//<![CDATA[\n$content\n//]]>')
                        else
                          Text(content)
                      ]
                    : null));
}

// Helper for expr: attributes
Map<String, String> expr(Map<String, String> attributes) {
  return attributes.map((key, value) => MapEntry('expr:$key', value));
}

class Expr {
  static Map<String, String> attr(String key, String value) => {'expr:$key': value};

  static String get(String value) => 'data:$value';

  static String resizeImage(String imageUrl, int newSize, [String? ratio, String? crop]) {
    var args = [imageUrl, newSize.toString()];
    if (ratio != null) args.add('"$ratio"');
    if (crop != null) args.add('"$crop"');
    return 'resizeImage(${args.join(", ")})';
  }
}

class Data {
  // Global Blog Data
  static const String blogTitle = 'data:blog.title';
  static const String blogUrl = 'data:blog.url';
  static const String blogPageTitle = 'data:blog.pageTitle';
  static const String blogPageType = 'data:blog.pageType';
  static const String blogHomepageUrl = 'data:blog.homepageUrl';
  static const String blogEncoding = 'data:blog.encoding';
  static const String blogLanguageDirection = 'data:blog.languageDirection';

  // View Data
  static const String isHomepage = 'data:view.isHomepage';
  static const String isPost = 'data:view.isPost';
  static const String isPage = 'data:view.isPage';
  static const String isSearch = 'data:view.isSearch';
  static const String isArchive = 'data:view.isArchive';
  static const String isMultipleItems = 'data:view.isMultipleItems';
  static const String isSingleItem = 'data:view.isSingleItem';
  static const String isError = 'data:view.isError';

  // Widget specific helpers
  static String widget(String value) => 'data:$value';
}

class Feeds {
  static String posts({int? maxResults, String? orderBy, String? alt, String? label}) {
    var path = 'feeds/posts/default';
    if (label != null) path += '/-/$label';
    var params = <String>[];
    if (maxResults != null) params.add('max-results=$maxResults');
    if (orderBy != null) params.add('orderby=$orderBy');
    if (alt != null) params.add('alt=$alt');
    var query = params.isNotEmpty ? '?${params.join("&")}' : '';
    return '${Data.blogHomepageUrl}$path$query';
  }

  static String summary({int? maxResults, String? alt}) {
    var params = <String>[];
    if (maxResults != null) params.add('max-results=$maxResults');
    if (alt != null) params.add('alt=$alt');
    var query = params.isNotEmpty ? '?${params.join("&")}' : '';
    return '${Data.blogHomepageUrl}feeds/summary$query';
  }
}
