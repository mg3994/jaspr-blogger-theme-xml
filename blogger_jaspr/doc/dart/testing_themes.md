# Testing Your Theme Components

`blogger_jaspr` is designed to be easily testable using the standard `dart:test` package.

## 1. Unit Testing Rendering
Since components are pure Dart objects, you can verify their XML output by running them through the `Renderer`.

```dart
import 'package:test/test.dart';
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  test('BIf renders correct condition', () {
    var renderer = Renderer();
    var component = BIf(cond: 'data:view.isPost', children: [Text('Hello')]);
    expect(renderer.render(component), equals('<b:if cond="data:view.isPost">Hello</b:if>'));
  });
}
```

## 2. Testing Complex Logic
You can test higher-order functions that build component trees.

```dart
test('SearchForm helper uses correct action', () {
  var form = MySearchHelper(); // Returns a Form component
  var xml = Renderer().render(form);
  expect(xml, contains('expr:action="data:blog.homepageUrl + &quot;search&quot;"'));
});
```

## 3. Best Practices
- **Isolation**: Test small components individually before testing the entire theme.
- **Escaping**: Always include tests for components that handle user input or complex JS to ensure XML entities are correctly generated.
- **Snapshots**: For large themes, you can compare the `generate()` output against a "golden" XML file to detect regressions.
