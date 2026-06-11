import 'package:web/web.dart';

void main() {
  print('Hello from Blogger Dart Client!');
  var body = document.querySelector('body') as HTMLElement?;
  if (body != null) {
    var div = document.createElement('div') as HTMLDivElement;
    div.innerText = 'This was added by Dart!';
    div.style.backgroundColor = 'yellow';
    div.style.padding = '10px';
    body.appendChild(div);
  }
}
