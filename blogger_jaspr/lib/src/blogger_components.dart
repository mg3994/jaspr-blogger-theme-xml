import 'core.dart';

class BSection extends DomComponent {
  BSection({
    String? id,
    String? className,
    String? maxwidgets,
    String? showaddelement,
    Iterable<Component>? children,
  }) : super('b:section', attributes: {
          if (id != null) 'id': id,
          if (className != null) 'class': className,
          if (maxwidgets != null) 'maxwidgets': maxwidgets,
          if (showaddelement != null) 'showaddelement': showaddelement,
        }, children: children);
}

class BWidget extends DomComponent {
  BWidget({
    required String id,
    required String type,
    String? title,
    bool? locked,
    Iterable<Component>? children,
  }) : super('b:widget', attributes: {
          'id': id,
          'type': type,
          if (title != null) 'title': title,
          if (locked != null) 'locked': locked ? 'yes' : 'no',
        }, children: children);
}

class BIf extends DomComponent {
  BIf({required String cond, Iterable<Component>? children})
      : super('b:if', attributes: {'cond': cond}, children: children);
}

class BElse extends DomComponent {
  BElse() : super('b:else');

  @override
  Iterable<Component> build() => [];
}

class BLoop extends DomComponent {
  BLoop({required String values, required String varName, Iterable<Component>? children})
      : super('b:loop', attributes: {'values': values, 'var': varName}, children: children);
}

class BData extends DomComponent {
  BData({required String value}) : super('data:$value');

  @override
  Iterable<Component> build() => []; // data tags are self-closing leaf nodes
}

class BSkin extends Component {
  final String css;
  const BSkin(this.css);

  @override
  Iterable<Component> build() => [
    DomComponent('b:skin', children: [
      RawText('<![CDATA[\n$css\n]]>')
    ])
  ];
}

class BInclude extends DomComponent {
  BInclude({required String name, String? data})
      : super('b:include', attributes: {
          'name': name,
          if (data != null) 'data': data,
        });
}

class BIncludable extends DomComponent {
  BIncludable({required String id, var varName, Iterable<Component>? children})
      : super('b:includable', attributes: {
          'id': id,
          if (varName != null) 'var': varName,
        }, children: children);
}

class BAttr extends DomComponent {
  BAttr({required String name, required String value})
      : super('b:attr', attributes: {'name': name, 'value': value});

  @override
  Iterable<Component> build() => [];
}

class BClass extends DomComponent {
  BClass({required String name, required String cond})
      : super('b:class', attributes: {'name': name, 'cond': cond});

  @override
  Iterable<Component> build() => [];
}

class BTag extends DomComponent {
  BTag({required String name, required String cond, Iterable<Component>? children})
      : super('b:tag', attributes: {'name': name, 'cond': cond}, children: children);
}

class BEval extends DomComponent {
  BEval({required String expr}) : super('b:eval', attributes: {'expr': expr});

  @override
  Iterable<Component> build() => [];
}

class BSwitch extends DomComponent {
  BSwitch({required String varName, Iterable<Component>? children})
      : super('b:switch', attributes: {'var': varName}, children: children);
}

class BCase extends DomComponent {
  BCase({required String value, Iterable<Component>? children})
      : super('b:case', attributes: {'value': value}, children: children);
}

class BDefault extends DomComponent {
  BDefault({Iterable<Component>? children}) : super('b:default', children: children);
}

class BMessage extends DomComponent {
  BMessage({required String name}) : super('b:message', attributes: {'name': name});

  @override
  Iterable<Component> build() => [];
}

class BComment extends Component {
  final String text;
  const BComment(this.text);

  @override
  Iterable<Component> build() => [RawText('<!-- $text -->')];
}

class BTemplateSkin extends Component {
  final String css;
  const BTemplateSkin(this.css);

  @override
  Iterable<Component> build() => [
        DomComponent('b:template-skin', children: [RawText('<![CDATA[\n$css\n]]>')])
      ];
}
