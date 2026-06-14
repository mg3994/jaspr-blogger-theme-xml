# blogger_jaspr Component Reference

All components in `blogger_jaspr` extend the `Component` base class and follow a consistent constructor pattern.

## Blogger-Specific Components

### `BSection`
Represents `<b:section>`.
- **Props**: `id`, `className`, `maxwidgets`, `showaddelement`, `growth`, `preferred`.
```dart
BSection(id: 'sidebar', className: 'side', showaddelement: 'yes')
```

### `BWidget`
Represents `<b:widget>`.
- **Props**: `id`, `type`, `title`, `locked`, `pageType`, `mobile`.
```dart
BWidget(id: 'Header1', type: 'Header', locked: true)
```

### `BIncludable` & `BInclude`
Represents `<b:includable>` and `<b:include>`.
```dart
BIncludable(id: 'main', children: [
  BInclude(name: 'post', data: 'p')
])
```

### Logic Components
- `BIf(cond: '...')`
- `BElseIf(cond: '...')`
- `BElse()`
- `BSwitch(varName: '...')` / `BCase(value: '...')` / `BDefault()`
- `BLoop(values: '...', varName: '...', index: '...')`
- `BEval(expr: '...')`
- `BWith(varName: '...', value: '...')`

### Data & Messaging
- `BData(value: '...')`: Outputs `<data:value/>`.
- `BMessage(name: '...')`: Outputs `<b:message name='...'/>`.
- `BArg(name: '...', value: '...', exprValue: '...')`: For includable arguments.

### Styling
- `BSkin(css, {variables})`: Includes a `<b:skin>` tag with optional `BVariable` / `BGroup` definitions.
- `BTemplateSkin(css)`: Includes a `<b:template-skin>` tag.

## HTML Components
Standard tags like `Div`, `P`, `Span`, `A`, `Img`, `Ul`, `Li`, `Form`, `Input`, `Button`, `Script`, `Style`.

### Semantic Tags
- `Header`, `Footer`, `Main`, `Nav`, `Section`, `Article`, `Aside`
- `H1`, `H2`, `H3`, `H4`, `H5`, `H6`
- `P`, `Div`, `Span`

### SEO & Layout
- `Meta(attributes: {'name': '...', 'content': '...'})`
- `Link(attributes: {'rel': '...', 'href': '...'})`
- `Base(attributes: {'href': '...'})`
- `Br()`
- `Hr()`
- `Img(attributes: {'src': '...', 'alt': '...'})`

### Interactivity
- `Script(src: '...', content: '...', contentInCDATA: true/false)`
  - Use `contentInCDATA: true` to wrap JS in a CDATA block and avoid XML escaping.

- **Attributes**: Passed via a `Map<String, String>`.

## Example: Building a Post Loop
```dart
BIncludable(
  id: 'main',
  children: [
    BLoop(
      values: 'data:posts',
      varName: 'p',
      children: [
        Div(
          attributes: {'class': 'post'},
          children: [
            BData(value: 'p.title'),
          ]
        ),
      ],
    ),
  ],
)
```
