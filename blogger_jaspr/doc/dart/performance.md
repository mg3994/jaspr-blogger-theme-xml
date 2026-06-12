# Performance & Optimization

Building themes with `blogger_jaspr` allows you to automate several performance best practices.

## 1. Image Resizing
Always resize images to their display size using the `Expr.resizeImage` helper. This reduces bandwidth and improves PageSpeed scores.

```dart
Img(attributes: Expr.attr('src', Expr.resizeImage('data:post.thumbnailUrl', 300, '1:1')))
```

## 2. JavaScript Optimization
`BClientScript` uses `dart compile js -O4`. This level of optimization includes:
- Dead code elimination.
- Aggressive minification.
- Type-informed optimizations.

**Tip**: Keep your client-side Dart file small and avoid heavy dependencies to keep the inlined script size down.

## 3. CSS Inlining
`BSkin` and `BTemplateSkin` inline your CSS directly into the head. To keep this efficient:
- Use Sass or another tool to pre-process your CSS if it gets large.
- Leverage the Blogger Template Designer (`BVariable`) instead of hardcoding many variations.

## 4. Reducing DOM Depth
Blogger already wraps sections and widgets in `div` tags. Avoid adding unnecessary extra `Div` components in your Dart code unless required for styling.
