import 'dart:io';
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  var theme = BloggerTheme(
    head: [
      Title(children: [BData(value: 'blog.pageTitle')]),
      BSkin('''
        body {
          background-color: #f0f0f0;
          font-family: sans-serif;
        }
        .main-content {
          margin: 20px;
          padding: 20px;
          background: white;
        }
      '''),
      BTemplateSkin('''
        /* Template Skin CSS */
      '''),
    ],
    body: [
      Div(
        attributes: {'class': 'main-content'},
        children: [
          BSection(
            id: 'main',
            className: 'main',
            showaddelement: 'yes',
            children: [
              BWidget(
                id: 'Blog1',
                type: 'Blog',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      BIf(
                        cond: 'data:view.isPost',
                        children: [
                          Div(children: [Text('You are viewing a post!')]),
                          BElse(),
                          Div(children: [Text('Welcome to my blog!')]),
                        ],
                      ),
                      Div(
                        attributes: Expr.attr('class', 'data:blog.pageType'),
                        children: [
                          Text('This div has a namespaced class attribute'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      BClientScript('example/client.dart'),
    ],
  );

  File('example/theme.xml').writeAsStringSync(theme.generate());
  print('Theme generated at example/theme.xml');
}
