# Advanced Patterns in blogger_jaspr

Beyond simple tags, `blogger_jaspr` allows for modular and dynamic theme construction.

## 1. Higher-Order Components
You can create reusable Dart functions or classes that return component trees.

```dart
Component PostThumbnail(String postVar) {
  return BIf(
    cond: 'data:$postVar.thumbnailUrl',
    children: [
      Div(
        attributes: {'class': 'thumb'},
        children: [
          Img(attributes: Expr.attr('src', Expr.resizeImage('data:$postVar.thumbnailUrl', 400))),
        ]
      )
    ]
  );
}
```

## 2. Mixing Raw XML
If you have a snippet of raw Blogger XML or HTML that you don't want to convert to components, use `RawText`.

```dart
Div(children: [
  RawText('<div class="legacy-html">...</div>'),
])
```

## 3. The `Expr` Helper Pattern
Always use `Expr.attr` for attributes starting with `expr:`. This makes it clear which attributes are static and which are dynamic Blogger expressions.

```dart
// Static
Div(attributes: {'class': 'container'})

// Dynamic
Div(attributes: Expr.attr('class', 'data:post.pageType'))
```

## 4. Conditional Attribute Merging
The `Html` component uses a special `_mergeAttributes` logic. You can use similar logic in your own components to provide defaults that users can override.
