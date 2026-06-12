import 'dart:io';
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  var theme = BloggerTheme(
    head: [
      Title(children: [BData(value: Data.blogPageTitle)]),
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
        .slider-container {
          position: relative;
          width: 100%;
          max-width: 800px;
          margin: auto;
          overflow: hidden;
        }
        .slide { display: none; }
        .slide img { width: 100%; }
        .slide-caption {
          position: absolute;
          bottom: 10px;
          left: 10px;
          background: rgba(0,0,0,0.5);
          color: white;
          padding: 5px;
        }
        .prev, .next {
          position: absolute;
          top: 50%;
          transform: translateY(-50%);
          background: rgba(0,0,0,0.5);
          color: white;
          border: none;
          cursor: pointer;
          padding: 10px;
        }
        .next { right: 0; }
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
      DomComponent('header', children: [
        Div(attributes: {'class': 'logo'}, children: [BData(value: 'blog.title')]),
        DomComponent('nav', attributes: {'class': 'main-nav'}, children: [
          BSection(
            id: 'nav-menu-section',
            maxwidgets: '1',
            showaddelement: 'yes',
            children: [
              BWidget(id: 'LinkList10', type: 'LinkList', title: 'Main Menu', locked: false),
            ],
          ),
        ]),
      ]),
      BTemplateSkin('''
        /* Template Skin CSS */
      '''),
    ],
    body: [
      BSection(
        id: 'featured',
        className: 'featured',
        children: [
          BWidget(
            id: 'Blog2',
            type: 'Blog',
            title: 'Featured Posts',
            children: [
              BIncludable(
                id: 'main',
                children: [
                  Div(
                    attributes: {'class': 'slider-container'},
                    children: [
                      Div(
                        attributes: {'class': 'slider-slides'},
                        children: [
                          BLoop(
                            values: 'data:posts where (p => p.labels any (l => l.name == "Featured"))',
                            varName: 'post',
                            children: [
                              Div(
                                attributes: {'class': 'slide'},
                                children: [
                                  DomComponent('img',
                                      attributes: Expr.attr(
                                          'src', Expr.resizeImage('data:post.thumbnailUrl', 800, '16:9'))),
                                  Div(
                                      attributes: {'class': 'slide-caption'},
                                      children: [BData(value: 'post.title')]),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Button(attributes: {'class': 'prev'}, children: [RawText('&#10094;')]),
                      Button(attributes: {'class': 'next'}, children: [RawText('&#10095;')]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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
                        cond: Data.isError,
                        children: [
                          Div(
                            attributes: {'class': 'error-page'},
                            children: [
                              DomComponent('h1', children: [Text('404 - Page Not Found')]),
                              Div(children: [BData(value: 'navMessage')]),
                              DomComponent('a',
                                  attributes: Expr.attr('href', Data.blogHomepageUrl),
                                  children: [Text('Return Home')]),
                            ],
                          ),
                        ],
                      ),
                      BIf(
                        cond: Data.isHomepage,
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
                      Div(
                        attributes: {'class': 'blog-pager', 'id': 'blog-pager'},
                        children: [
                          BIf(
                            cond: 'data:olderPageUrl',
                            children: [
                              DomComponent('a',
                                  attributes: {
                                    'class': 'older-link',
                                    ...Expr.attr('href', 'data:olderPageUrl'),
                                    ...Expr.attr('title', 'data:olderPageTitle'),
                                  },
                                  children: [
                                    Text('← Older Posts'),
                                  ]),
                            ],
                          ),
                          BIf(
                            cond: 'data:newerPageUrl',
                            children: [
                              DomComponent('a',
                                  attributes: {
                                    'class': 'newer-link',
                                    ...Expr.attr('href', 'data:newerPageUrl'),
                                    ...Expr.attr('title', 'data:newerPageTitle'),
                                  },
                                  children: [
                                    Text('Newer Posts →'),
                                  ]),
                            ],
                          ),
                          DomComponent('a',
                              attributes: {
                                'class': 'home-link',
                                ...Expr.attr('href', 'data:blog.homepageUrl'),
                              },
                              children: [
                                Text('Home'),
                              ]),
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
                          Div(
                            attributes: {'class': 'post-thumb'},
                            children: [
                              DomComponent('a',
                                  attributes: Expr.attr('href', 'data:post.url'),
                                  children: [
                                    DomComponent('img',
                                        attributes: Expr.attr('src', Expr.resizeImage('data:post.thumbnailUrl', 300, '1:1'))),
                                  ]),
                            ],
                          ),
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
                              DomComponent('span', children: [Text('Posted in: ')]),
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
                      BComment(children: [Text('Third-party Comments Section')]),
                      BIf(
                        cond: 'data:view.isPost',
                        children: [
                          Div(
                            attributes: {'id': 'disqus_thread'},
                            children: [
                              Script(content: '/* Disqus JS here */'),
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
              BWidget(
                id: 'HTML1',
                type: 'HTML',
                locked: false,
                title: 'Search',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      Form(
                        attributes: {
                          'class': 'custom-search-form',
                          ...Expr.attr('action', '${Data.blogHomepageUrl} + "search"'),
                        },
                        children: [
                          Input(attributes: {
                            'type': 'text',
                            'name': 'q',
                            'placeholder': 'Search this blog...',
                          }),
                          Button(
                            attributes: {'type': 'submit'},
                            children: [Text('Search')],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              BWidget(id: 'Label1', type: 'Label', locked: false, title: 'Categories'),
              BWidget(
                id: 'HTMLRecentPosts',
                type: 'HTML',
                locked: false,
                title: 'Recent Posts',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      Div(attributes: {'id': 'recent-posts-container'}, children: [Text('Loading...')]),
                    ],
                  ),
                ],
              ),
              BWidget(id: 'Pages1', type: 'Pages', locked: false, title: 'Main Menu'),
              BWidget(
                id: 'Profile1',
                type: 'Profile',
                locked: false,
                title: 'About Me',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      BIf(
                        cond: 'data:team == "true"',
                        children: [
                          BLoop(
                            values: 'data:authors',
                            varName: 'author',
                            children: [
                              Div(children: [BData(value: 'author.displayname')]),
                            ],
                          ),
                        ],
                        // BElse() could be used here but the doc snippet just showed the if
                      ),
                      BIf(
                        cond: 'data:photo.url',
                        children: [
                          DomComponent('img',
                              attributes: {
                                ...Expr.attr('src', 'data:photo.url'),
                                ...Expr.attr('alt', 'data:photo.alt'),
                                'width': 'data:photo.width',
                                'height': 'data:photo.height',
                              }),
                        ],
                      ),
                      Div(children: [BData(value: 'aboutme')]),
                    ],
                  ),
                ],
              ),
              BWidget(
                id: 'LinkList1',
                type: 'LinkList',
                locked: false,
                title: 'Social Links',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      DomComponent('ul', children: [
                        BLoop(
                          values: 'data:links',
                          varName: 'link',
                          children: [
                            DomComponent('li', children: [
                              DomComponent('a',
                                  attributes: Expr.attr('href', 'data:link.target'),
                                  children: [BData(value: 'link.name')]),
                            ]),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
              BWidget(
                id: 'HTML3',
                type: 'HTML',
                locked: false,
                title: 'Feeds',
                children: [
                  BIncludable(
                    id: 'main',
                    children: [
                      Div(children: [
                        DomComponent('a',
                            attributes: Expr.attr('href', Feeds.posts()),
                            children: [Text('Atom Post Feed')]),
                        Text(' | '),
                        DomComponent('a',
                            attributes: Expr.attr('href', Feeds.posts(alt: 'rss')),
                            children: [Text('RSS Post Feed')]),
                      ]),
                    ],
                  ),
                ],
              ),
              BSection(
                id: 'sidebar-ads',
                showaddelement: 'yes',
                children: [
                  BWidget(
                    id: 'AdSense1',
                    type: 'AdSense',
                    title: 'Advertisement',
                    children: [
                      BIncludable(
                        id: 'main',
                        children: [
                          BIf(
                            cond: '${Data.isPost} or ${Data.isPage}',
                            children: [
                              Div(
                                attributes: {'class': 'widget-content'},
                                children: [
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
        ],
      ),
      BClientScript('example/client.dart'),
      Script(children: [
        Text('\n      cookieOptions = {\n       close: "Got it!",\n       learn: "Privacy Policy",\n       link: "'),
        BData(value: 'blog.canonicalHomepageUrl'),
        Text('p/privacy-policy.html"\n      };\n    '),
      ]),
    ],
  );

  File('example/theme.xml').writeAsStringSync(theme.generate());
  print('Theme generated at example/theme.xml');
}
