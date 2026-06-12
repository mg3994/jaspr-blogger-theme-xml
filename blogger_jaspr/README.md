# blogger_jaspr

A lightweight, standalone Dart framework for designing Blogger XML themes with a Jaspr-inspired DSL.

## Features
- **Jaspr-inspired DSL**: Build Blogger XML themes using Dart components.
- **Full Tag Support**: Supports all `<b:*>` tags, `<data:*>` tags, and `expr:` attributes.
- **Client-Side Dart**: Write interactive logic in Dart; compile and inline it safely into XML.
- **Template Designer**: Built-in support for Variable and Group definitions.
- **Type-Safe**: Leverage Dart's type system for more reliable theme development.

## Installation
Add to your `pubspec.yaml`:
```yaml
dependencies:
  blogger_jaspr:
    path: ./path/to/library
```

## Quick Start
```dart
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  var theme = BloggerTheme(
    head: [
      Title(children: [BData(value: Data.blogPageTitle)]),
      BSkin('body { background: white; }'),
    ],
    body: [
      BSection(id: 'main', children: [
        BWidget(id: 'Blog1', type: 'Blog'),
      ]),
    ],
  );

  print(theme.generate());
}
```

## Documentation
See the [doc/](doc/README.md) folder for comprehensive guides:
- [Blogger XML Reference](doc/blogger/README.md)
- [Dart Framework API Reference](doc/dart/README.md)
