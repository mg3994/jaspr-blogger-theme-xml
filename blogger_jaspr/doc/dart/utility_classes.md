# blogger_jaspr Utility Classes

Helpers to make theme development more readable and type-safe.

## `Data`
Commonly used Blogger data tag constants.
```dart
BIf(cond: Data.isHomepage)
```
Includes: `blogTitle`, `blogUrl`, `isHomepage`, `isPost`, `isError`, etc.

## `Expr`
Helpers for `expr:` attributes.
```dart
Div(attributes: Expr.attr('class', 'data:post.pageType'))
```

### `Expr.resizeImage`
Generates the Blogger image resizing operator.
```dart
Img(attributes: Expr.attr('src', Expr.resizeImage('data:post.thumbnailUrl', 400, '16:9')))
```

## `Feeds`
Generate feed URLs dynamically.
```dart
A(attributes: Expr.attr('href', Feeds.posts(maxResults: 5)))
```

## `BloggerTheme`
The top-level utility to generate the theme boilerplate.
- **`head`**: List of head components.
- **`body`**: List of body components.
- **`attributes`**: Optional attributes for the `<html>` tag.

```dart
BloggerTheme(
  head: [...],
  body: [...],
).generate(); // Returns full XML string
```
