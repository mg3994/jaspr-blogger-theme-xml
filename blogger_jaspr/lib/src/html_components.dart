import 'core.dart';

class Html extends DomComponent {
  Html({Map<String, String>? attributes, Iterable<Component>? children})
      : super('html',
            attributes: {
              // if they are not specified we will default o prefer using these values for better compatibility with Blogger's template requirements shown below, but they can be overridden if needed
              'b:css': 'false',
              'b:defaultwidgetversion': '2',
              'b:layoutsversion': '3',
              'b:responsive': 'true',
              'expr:dir': 'data:blog.languageDirection',
              'expr:lang': 'data:blog.locale',
              //  below are the standard XML namespaces for Blogger templates and they are fixed
              'xmlns': 'http://www.w3.org/1999/xhtml',
              'xmlns:b': 'http://www.google.com/2005/gml/b',
              'xmlns:data': 'http://www.google.com/2005/gml/data',
              'xmlns:expr': 'http://www.google.com/2005/gml/expr',
              ...?attributes,
            },
            children: children);
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

class Div extends DomComponent {
  Div({Map<String, String>? attributes, Iterable<Component>? children})
      : super('div', attributes: attributes, children: children);
}

class Script extends DomComponent {
  Script({String? src, String? type, String? content})
      : super('script',
            attributes: {
              if (src != null) 'src': src,
              if (type != null) 'type': type,
            },
            children: content != null ? [Text(content)] : null);
}

// Helper for expr: attributes
Map<String, String> expr(Map<String, String> attributes) {
  return attributes.map((key, value) => MapEntry('expr:$key', value));
}

class Expr {
  static Map<String, String> attr(String key, String value) => {'expr:$key': value};

  static String get(String value) => 'data:$value';
}
