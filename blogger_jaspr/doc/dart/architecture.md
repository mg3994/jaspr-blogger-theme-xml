# Framework Architecture

`blogger_jaspr` is designed with a lightweight, functional approach to XML generation.

## 1. The Component Model
At the core is the `Component` abstract class. Every element in your theme is a component.
- **`build()`**: This method returns an `Iterable<Component>`. This allows components to compose other components, similar to Flutter or Jaspr.
- **`DomComponent`**: A specialized component that represents an actual XML tag (e.g., `div`, `b:if`). It handles attributes and child rendering.

## 2. The Rendering Pipeline
The `Renderer` class performs a depth-first traversal of the component tree.
1. If a component is a `Text` node, it escapes the content (unless `RawText` is used).
2. If it's a `DomComponent`, it writes the opening tag, attributes, recursively renders children, and then writes the closing tag.
3. If it's any other component, it calls `build()` and renders the resulting children.

## 3. Automatic Escaping & Safety
Unlike standard HTML generators, `blogger_jaspr` is tuned for Blogger's strict XML parser.
- **Entity Conversion**: Characters like `&` and `<` are converted to `&amp;` and `&lt;` during the render phase.
- **Control Characters**: Restricted XML 1.0 control characters (e.g., null bytes) are replaced with spaces to prevent upload failures.
- **Tag Names**: Namespaces like `b:`, `data:`, and `expr:` are treated as part of the tag name or attribute key, ensuring correct XML namespace output.

## 4. JS Compilation Hook
`BClientScript` leverages the Dart SDK to perform out-of-band compilation. It acts as a bridge between the static XML generation and the dynamic client-side environment, ensuring that the final output is a single, self-contained file.
