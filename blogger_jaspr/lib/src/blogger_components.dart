import 'core.dart';

class BSection extends DomComponent {
  BSection({
    required String id,
    String? className,
    String? maxwidgets,
    String? showaddelement,
    String? growth,
    String? preferred,
    Iterable<Component>? children,
  }) : super('b:section',
            attributes: {
              'id': id,
              if (className != null) 'class': className,
              if (maxwidgets != null) 'maxwidgets': maxwidgets,
              if (showaddelement != null) 'showaddelement': showaddelement,
              if (growth != null) 'growth': growth,
              if (preferred != null) 'preferred': preferred,
            },
            children: children);
}

class BWidget extends DomComponent {
  BWidget({
    required String id,
    required String type,
    String? title,
    bool? locked,
    String? pageType,
    String? mobile,
    Iterable<Component>? children,
  }) : super('b:widget',
            attributes: {
              'id': id,
              'type': type,
              if (title != null) 'title': title,
              if (locked != null) 'locked': locked ? 'yes' : 'no',
              if (pageType != null) 'pageType': pageType,
              if (mobile != null) 'mobile': mobile,
            },
            children: children);
}

class BIf extends DomComponent {
  BIf({required String cond, Iterable<Component>? children})
      : super('b:if', attributes: {'cond': cond}, children: children);
}

class BElseIf extends DomComponent {
  BElseIf({required String cond}) : super('b:elseif', attributes: {'cond': cond});

  @override
  Iterable<Component> build() => [];
}

class BElse extends DomComponent {
  BElse() : super('b:else');

  @override
  Iterable<Component> build() => [];
}

class BArg extends DomComponent {
  BArg({required String name, String? value, String? exprValue})
      : super('b:arg',
            attributes: {
              'name': name,
              if (value != null) 'value': value,
              if (exprValue != null) 'expr:value': exprValue,
            });

  @override
  Iterable<Component> build() => [];
}

class BLoop extends DomComponent {
  BLoop({
    required String values,
    required String varName,
    String? index,
    Iterable<Component>? children,
  }) : super('b:loop',
            attributes: {
              'values': values,
              'var': varName,
              if (index != null) 'index': index,
            },
            children: children);
}

class BData extends DomComponent {
  BData({required String value}) : super('data:$value');

  @override
  Iterable<Component> build() => []; // data tags are self-closing leaf nodes
}

class BSkin extends Component {
  final String css;
  final List<dynamic>? variables; // List of BVariable or BGroup
  final bool useStyleTag;

  const BSkin(this.css, {this.variables, this.useStyleTag = false});

  @override
  Iterable<Component> build() {
    var sb = StringBuffer();
    if (variables != null && variables!.isNotEmpty) {
      sb.writeln("/*");
      sb.writeln(" * Variable definitions:");
      for (var v in variables!) {
        sb.writeln(v.toString());
      }
      sb.writeln(" */");
    }
    sb.write(css);

    var content = sb.toString();
    if (useStyleTag) {
      content = "<style type='text/css'>\n$content\n</style>";
    }

    return [
      XmlComment('prettier-ignore'),
      DomComponent('b:skin', children: [RawText('<![CDATA[\n$content\n]]>')]),
    ];
  }
}

class BInclude extends DomComponent {
  BInclude({required String name, String? data, String? cond})
      : super('b:include', attributes: {
          'name': name,
          if (data != null) 'data': data,
          if (cond != null) 'cond': cond,
        });
}

class BIncludable extends DomComponent {
  BIncludable({required String id, String? varName, Iterable<Component>? children})
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

class BWith extends DomComponent {
  BWith({required String varName, required String value, Iterable<Component>? children})
      : super('b:with', attributes: {'var': varName, 'value': value}, children: children);
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
  BMessage({required String name, Iterable<Component>? children})
      : super('b:message', attributes: {'name': name}, children: children);
}

class BVariable {
  final String name;
  final String description;
  final String type;
  final String defaultValue;
  final String? value;

  const BVariable({
    required this.name,
    required this.description,
    required this.type,
    required this.defaultValue,
    this.value,
  });

  @override
  String toString() {
    return " <Variable name=\"$name\" description=\"$description\" type=\"$type\" default=\"$defaultValue\"${value != null ? " value=\"$value\"" : ""}/>";
  }
}

class BGroup {
  final String description;
  final String? selector;
  final List<BVariable> variables;

  const BGroup({
    required this.description,
    this.selector,
    required this.variables,
  });

  @override
  String toString() {
    var sb = StringBuffer();
    sb.writeln(" <Group description=\"$description\"${selector != null ? " selector=\"$selector\"" : ""}>");
    for (var v in variables) {
      sb.writeln(v.toString());
    }
    sb.write(" </Group>");
    return sb.toString();
  }
}

class BComment extends DomComponent {
  BComment({Iterable<Component>? children}) : super('b:comment', children: children);
}

class XmlComment extends Component {
  final String text;
  const XmlComment(this.text);

  @override
  Iterable<Component> build() => [RawText('<!-- $text -->')];
}

class BTemplateSkin extends Component {
  final String css;
  const BTemplateSkin(this.css);

  @override
  Iterable<Component> build() => [
        XmlComment('prettier-ignore'),
        DomComponent('b:template-skin', children: [RawText('<![CDATA[\n$css\n]]>')])
      ];
}
