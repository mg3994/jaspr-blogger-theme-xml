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
