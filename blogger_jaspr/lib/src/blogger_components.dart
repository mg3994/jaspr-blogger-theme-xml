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
