import 'dart:io';
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  var theme = BloggerTheme(
    head: [
      Title(children: [BData(value: 'blog.pageTitle')]),
      BSkin(
        '''
        body {
          background: \$bgcolor;
          font-family: sans-serif;
        }
        .main-content {
          margin: 20px;
          padding: 20px;
          background: white;
        }
      ''',
        variables: [
          BVariable(
            name: 'bgcolor',
            description: 'Page Background Color',
            type: 'color',
            defaultValue: '#fff',
          ),
        ],
      ),
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
                      BComment(children: [Text('Only include the first 10 posts')]),
                      BLoop(
                        varName: 'p',
                        index: 'index',
                        values: 'data:posts',
                        children: [
                          BInclude(
                            name: 'post',
                            data: 'p',
                            cond: 'data:index < 10',
                          ),
                        ],
                      ),
                      BIf(
                        cond: 'data:view.isPost',
                        children: [
                          Div(children: [Text('You are viewing a post!')]),
                          BElseIf(cond: 'data:view.isPage'),
                          Div(children: [Text('You are viewing a page!')]),
                          BElse(),
                          Div(children: [Text('Welcome to my blog!')]),
                        ],
                      ),
                      BWith(
                        varName: 'style',
                        value: '"color: red;"',
                        children: [
                          Div(
                            attributes: Expr.attr('style', 'data:style'),
                            children: [
                              Text('This has a red color via b:with'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  BIncludable(
                    id: 'post',
                    varName: 'post',
                    children: [
                      Text('Title: '),
                      BData(value: 'post.title'),
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
