# blogger_jaspr Documentation

`blogger_jaspr` is a lightweight, standalone Dart framework for designing Blogger XML themes using a Jaspr-inspired DSL. It allows you to build sophisticated, single-file Blogger templates with the power of Dart's type system and component-based architecture.

## Key Features
- **Jaspr-like DSL**: Familiar component-based syntax for building XML structures.
- **Full Blogger Support**: Built-in components for all Blogger-specific tags and attributes.
- **Automatic JS Inlining**: Compile Dart scripts to XML-safe JavaScript and inline them automatically.
- **Robust XML Safety**: Custom escaping for JS symbols and restricted characters.
- **Single File Output**: Generate a valid `.xml` theme file with one command.

## Getting Started

### 1. Initialize Project
Create a new Dart project and add `blogger_jaspr` to your `pubspec.yaml`.

### 2. Define Your Theme
```dart
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  var theme = BloggerTheme(
    head: [
      Title(children: [BData(value: Data.blogPageTitle)]),
      BSkin('body { color: red; }'),
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

### 3. Generate XML
Run your Dart script to output the theme.
```bash
dart run your_script.dart > theme.xml
```
