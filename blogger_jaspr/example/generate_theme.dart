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
      // Header Section
      BSection(
        className: 'header',
        id: 'header',
        maxwidgets: '1',
        showaddelement: 'no',
        children: [
          BWidget(
            id: 'Header1',
            type: 'Header',
            locked: true,
            title: 'My Awesome Blog (Header)',
          ),
        ],
      ),
      Div(
        attributes: {'class': 'main-content'},
        children: [
          // Main Content Section
          BSection(
            id: 'main',
            className: 'main',
            showaddelement: 'yes',
            children: [
              BWidget(
                id: 'Blog1',
                type: 'Blog',
                locked: true,
                title: 'Blog Posts',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      BIf(
                        cond: 'data:view.isHomepage',
                        children: [
                          Div(
                            attributes: {'class': 'welcome-banner'},
                            children: [
                              DomComponent('h2', children: [Text('Welcome to our Blog!')]),
                            ],
                          ),
                        ],
                      ),
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
                    ],
                  ),
                  BIncludable(
                    id: 'post',
                    varName: 'post',
                    children: [
                      BIf(
                        cond: 'data:post.thumbnailUrl',
                        children: [
                          DomComponent('img', attributes: Expr.attr('src', 'data:post.thumbnailUrl')),
                          BElse(),
                          DomComponent('img', attributes: {'src': 'https://via.placeholder.com/150'}),
                        ],
                      ),
                      DomComponent('h2', children: [
                        DomComponent('a', attributes: Expr.attr('href', 'data:post.url'), children: [
                          BData(value: 'post.title'),
                        ]),
                      ]),
                      BIf(
                        cond: 'data:post.labels',
                        children: [
                          Div(
                            attributes: {'class': 'post-labels'},
                            children: [
                              DomComponent('span', children: [Text('Tags: ')]),
                              BLoop(
                                values: 'data:post.labels',
                                varName: 'label',
                                children: [
                                  DomComponent('a',
                                      attributes: {
                                        ...Expr.attr('href', 'data:label.url'),
                                        'rel': 'tag',
                                      },
                                      children: [
                                        BData(value: 'label.name'),
                                      ]),
                                  BIf(cond: '!data:label.isLast', children: [Text(', ')]),
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
            ],
          ),
          // Sidebar Section
          BSection(
            id: 'sidebar',
            className: 'sidebar',
            preferred: 'yes',
            showaddelement: 'yes',
            children: [
              BWidget(id: 'Label1', type: 'Label', locked: false, title: 'Categories'),
              BWidget(
                id: 'HTML2',
                type: 'HTML',
                locked: false,
                title: 'Sidebar Ad',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      BIf(
                        cond: 'data:view.isPost or data:view.isPage',
                        children: [
                          Div(
                            attributes: {'class': 'widget-content'},
                            children: [
                              DomComponent('h4', children: [Text('Advertisement')]),
                              BData(value: 'content'),
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
        ],
      ),
      BClientScript('example/client.dart'),
    ],
  );

  File('example/theme.xml').writeAsStringSync(theme.generate());
  print('Theme generated at example/theme.xml');
}
