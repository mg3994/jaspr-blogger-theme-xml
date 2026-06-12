# Client-Side Logic in blogger_jaspr

You can write your blog's interactive logic in Dart, which `blogger_jaspr` will compile to JavaScript and inline safely into your XML theme.

## How it works
The `BClientScript` component takes a path to a Dart file. During the rendering process, the framework:
1. Calls `dart compile js -O4`.
2. Reads the generated JavaScript.
3. XML-escapes all special characters (e.g., `&` becomes `&amp;`) to ensure the theme file is valid.
4. Inlines the JS into a `<script>` tag.

## Example

### 1. Create a client script (`client.dart`)
```dart
import 'package:web/web.dart';

void main() {
  print("Interactive theme enabled!");
  var header = document.querySelector('header');
  header?.style.backgroundColor = 'blue';
}
```

### 2. Use in your theme
```dart
import 'package:blogger_jaspr/blogger_jaspr.dart';

var theme = BloggerTheme(
  head: [...],
  body: [
    BSection(...),
    BClientScript('lib/client.dart'), // Path to your dart file
  ],
);
```

## Mixed Content (JS + Blogger Tags)
Sometimes you need to mix raw JavaScript with Blogger data tags (e.g., for configuration objects). Since `Text` components are XML-escaped by default, you can use `children` in the `Script` component to combine `Text` and `BData`.

### Example: Cookie Options
To achieve this output:
```html
<script>
  cookieOptions = {
    link: "<data:blog.canonicalHomepageUrl/>p/privacy.html"
  };
</script>
```

Use this Dart code:
```dart
Script(children: [
  Text('\n  cookieOptions = {\n    link: "'),
  BData(value: 'blog.canonicalHomepageUrl'),
  Text('p/privacy.html"\n  };\n'),
])
```
The `BData` component renders as a self-closing tag (`<data:.../>`) which is valid XML, while the surrounding `Text` remains properly escaped but allows `<` and `>` through the tag structure itself.

## Security & Performance
- **No CDATA**: Scripts are fully escaped, not wrapped in CDATA, as per common Blogger compatibility requirements.
- **Optimization**: The `-O4` flag is used for aggressive minification.
