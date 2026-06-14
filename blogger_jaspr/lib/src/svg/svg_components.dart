import '../core.dart';

class Svg extends DomComponent {
  Svg({
    String? viewBox,
    String? width,
    String? height,
    String? fill,
    String? stroke,
    String? strokeWidth,
    String? strokeLinecap,
    String? strokeLinejoin,
    Map<String, String>? attributes,
    Iterable<dynamic>? children,
  }) : super('svg',
            attributes: {
              if (viewBox != null) 'viewBox': viewBox,
              if (width != null) 'width': width,
              if (height != null) 'height': height,
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              if (strokeWidth != null) 'stroke-width': strokeWidth,
              if (strokeLinecap != null) 'stroke-linecap': strokeLinecap,
              if (strokeLinejoin != null) 'stroke-linejoin': strokeLinejoin,
              ...?attributes,
            },
            children: children);
}

class Path extends DomComponent {
  Path({
    required String d,
    String? fill,
    String? stroke,
    Map<String, String>? attributes,
  }) : super('path',
            attributes: {
              'd': d,
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              ...?attributes,
            });

  @override
  Iterable<dynamic> build() => [];
}

class Rect extends DomComponent {
  Rect({
    String? x,
    String? y,
    String? width,
    String? height,
    String? rx,
    String? ry,
    String? fill,
    String? stroke,
    Map<String, String>? attributes,
  }) : super('rect',
            attributes: {
              if (x != null) 'x': x,
              if (y != null) 'y': y,
              if (width != null) 'width': width,
              if (height != null) 'height': height,
              if (rx != null) 'rx': rx,
              if (ry != null) 'ry': ry,
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              ...?attributes,
            });

  @override
  Iterable<dynamic> build() => [];
}

class Circle extends DomComponent {
  Circle({
    required String cx,
    required String cy,
    required String r,
    String? fill,
    String? stroke,
    Map<String, String>? attributes,
  }) : super('circle',
            attributes: {
              'cx': cx,
              'cy': cy,
              'r': r,
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              ...?attributes,
            });

  @override
  Iterable<dynamic> build() => [];
}

class Line extends DomComponent {
  Line({
    required String x1,
    required String y1,
    required String x2,
    required String y2,
    String? stroke,
    String? strokeWidth,
    Map<String, String>? attributes,
  }) : super('line',
            attributes: {
              'x1': x1,
              'y1': y1,
              'x2': x2,
              'y2': y2,
              if (stroke != null) 'stroke': stroke,
              if (strokeWidth != null) 'stroke-width': strokeWidth,
              ...?attributes,
            });

  @override
  Iterable<dynamic> build() => [];
}

class Polygon extends DomComponent {
  Polygon({
    required String points,
    String? fill,
    String? stroke,
    Map<String, String>? attributes,
  }) : super('polygon',
            attributes: {
              'points': points,
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              ...?attributes,
            });

  @override
  Iterable<dynamic> build() => [];
}

class Polyline extends DomComponent {
  Polyline({
    required String points,
    String? fill,
    String? stroke,
    Map<String, String>? attributes,
  }) : super('polyline',
            attributes: {
              'points': points,
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              ...?attributes,
            });

  @override
  Iterable<dynamic> build() => [];
}

class Ellipse extends DomComponent {
  Ellipse({
    required String cx,
    required String cy,
    required String rx,
    required String ry,
    String? fill,
    String? stroke,
    Map<String, String>? attributes,
  }) : super('ellipse',
            attributes: {
              'cx': cx,
              'cy': cy,
              'rx': rx,
              'ry': ry,
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              ...?attributes,
            });

  @override
  Iterable<dynamic> build() => [];
}

class G extends DomComponent {
  G({
    String? fill,
    String? stroke,
    Map<String, String>? attributes,
    Iterable<dynamic>? children,
  }) : super('g',
            attributes: {
              if (fill != null) 'fill': fill,
              if (stroke != null) 'stroke': stroke,
              ...?attributes,
            },
            children: children);
}
