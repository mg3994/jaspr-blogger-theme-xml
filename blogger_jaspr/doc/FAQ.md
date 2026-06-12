# Frequently Asked Questions (FAQ)

## 1. Why doesn't `blogger_jaspr` use CDATA for scripts?
Blogger's XML parser is strict and often fails to correctly process CDATA blocks inside `<script>` tags, especially when combined with other Blogger-specific tags. By XML-escaping special symbols (like `&` to `&amp;`), we ensure the generated file is always a valid, parsable XML document that Blogger will accept.

## 2. How do I include Blogger data tags inside my JavaScript?
Use the "Mixed Content" pattern. Pass the script content as `children` to the `Script` component, and interleave `Text` and `BData` components.

```dart
Script(children: [
  Text('var url = "'),
  BData(value: 'blog.url'),
  Text('";'),
])
```

## 3. Can I use third-party libraries like jQuery or React?
Yes. You can include them via standard `<script src="...">` tags. However, if you want to write your interactive logic in Dart, `BClientScript` is the recommended way to keep everything in one language and one file.

## 4. Does this framework support all Blogger versions?
`blogger_jaspr` is optimized for **Layouts Version 3** and **Widget Version 2**, which are the current standards for modern Blogger themes. It may work with older versions, but some newer tags like `<b:template-skin>` require these versions to be specified in the `<html>` tag.

## 5. How do I format the generated XML?
The `Renderer` produces a compact XML string to minimize file size. If you need a readable version for debugging, you can run the output through an external XML formatter, but remember to preserve the CDATA blocks inside `<b:skin>`.
