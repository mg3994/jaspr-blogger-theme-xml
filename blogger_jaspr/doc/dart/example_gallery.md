# Example Gallery

Common Blogger UI patterns implemented with `blogger_jaspr`.

## 1. Breadcrumbs
Show the current post's category path.

```dart
BIf(
  cond: Data.isPost,
  children: [
    Div(
      attributes: {'class': 'breadcrumbs'},
      children: [
        DomComponent('a', attributes: Expr.attr('href', Data.blogHomepageUrl), children: [Text('Home')]),
        Text(' » '),
        BLoop(
          values: 'data:post.labels',
          varName: 'label',
          children: [
            DomComponent('a', attributes: Expr.attr('href', 'data:label.url'), children: [BData(value: 'label.name')]),
            BIf(cond: '!data:label.isLast', children: [Text(' » ')]),
          ],
        ),
      ],
    ),
  ],
)
```

## 4. Accordion Menu with Widget Settings
Manage menu items via the Blogger dashboard while maintaining complex HTML/JS logic.

```dart
BWidget(
  id: 'LinkList3',
  type: 'LinkList',
  locked: false,
  title: 'Workspace Menu',
  version: '2',
  children: [
    BWidgetSettings(children: [
      BWidgetSetting(name: 'text-0', children: ["Nearby Helpers"]),
      BWidgetSetting(name: 'link-0', children: ["#"]),
    ]),
    BIncludable(
      id: 'main',
      children: [
        Div(attributes: {'class': 'module-wrapper'}, children: [
          Button(
            attributes: {'onclick': 'toggle()'},
            children: [Span(children: ["Options"])],
          ),
          Ul(children: [
            BLoop(
              values: 'data:links',
              varName: 'link',
              children: [
                Li(children: [
                  A(attributes: Expr.attr('href', 'data:link.target'), children: [BData(value: 'link.name')]),
                ])
              ],
            )
          ])
        ])
      ],
    )
  ],
)
```

## 5. Social Icon Matrix (SVG)
Use the advanced SVG components to create a crisp, theme-aware social link matrix.

```dart
Div(attributes: {'class': 'sidebar-social-wrapper'}, children: [
  A(
    attributes: {
      'aria-label': 'YouTube',
      'class': 'social-icon-link',
      'href': 'https://www.youtube.com/@Antinna',
      'target': '_blank'
    },
    children: [
      Svg(
        fill: 'none',
        height: '18',
        stroke: 'currentColor',
        strokeLinecap: 'round',
        strokeLinejoin: 'round',
        strokeWidth: '2',
        viewBox: '0 0 24 24',
        width: '18',
        children: [
          Path(d: 'M22.54 6.42a2.78 2.78 0 0 0-1.94-2C18.88 4 12 4 12 4s-6.88 0-8.6.46a2.78 2.78 0 0 0-1.94 2A29 29 0 0 0 1 11.75a29 29 0 0 0 .46 5.33A2.78 2.78 0 0 0 3.4 19c1.72.46 8.6.46 8.6.46s6.88 0 8.6-.46a2.78 2.78 0 0 0 1.94-2 29 29 0 0 0 .46-5.25 29 29 0 0 0-.46-5.33z'),
          Polygon(points: '9.75 15.02 15.5 11.75 9.75 8.48 9.75 15.02', fill: 'currentColor'),
        ],
      ),
    ],
  ),
])
```

## 2. Author Box
Display author information at the end of a post.

```dart
Div(
  attributes: {'class': 'author-box'},
  children: [
    DomComponent('img', attributes: Expr.attr('src', 'data:post.authorPhoto.url')),
    Div(children: [
      DomComponent('h3', children: [BData(value: 'post.author')]),
      P(children: [BData(value: 'post.authorAboutMe')]),
    ]),
  ],
)
```

## 3. Social Share Links
Dynamic sharing buttons for the current post.

```dart
Div(
  attributes: {'class': 'share-buttons'},
  children: [
    DomComponent('a',
      attributes: Expr.attr('href', '"https://twitter.com/intent/tweet?url=" + data:post.url + "&text=" + data:post.title'),
      children: [Text('Tweet')]
    ),
    DomComponent('a',
      attributes: Expr.attr('href', '"https://www.facebook.com/sharer.php?u=" + data:post.url'),
      children: [Text('Share')]
    ),
  ],
)
```
