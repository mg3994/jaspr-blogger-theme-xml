import 'dart:io';
import 'package:blogger_jaspr/blogger_jaspr.dart';

void main() {
  var theme = Html(
    children: [
      Head(
        children: [
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
        ],
      ),
      Body(
        children: [
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
                      BIf(
                        cond: 'data:view.isPost',
                        children: [
                          Div(children: [Text('You are viewing a post!')]),
                          BElse(),
                          Div(children: [Text('Welcome to my blog!')]),
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
      ),
    ],
  );

  var renderer = Renderer();
  var xml = '<?xml version="1.0" encoding="UTF-8" ?>\n'
      '<!DOCTYPE html>\n'
      '${renderer.render(theme)}';

  File('example/theme.xml').writeAsStringSync(xml);
  print('Theme generated at example/theme.xml');
}
