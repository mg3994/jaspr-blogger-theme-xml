import 'dart:convert';
import 'dart:js_interop';
import 'package:web/web.dart';

void main() {
  print('Hello from Blogger Dart Client!');

  // Slider Logic
  var slider = document.querySelector('.slider-container');
  if (slider != null) {
    var slides = slider.querySelectorAll('.slide');
    var prevButton = slider.querySelector('.prev') as HTMLButtonElement?;
    var nextButton = slider.querySelector('.next') as HTMLButtonElement?;
    int currentIndex = 0;

    void showSlide(int index) {
      for (int i = 0; i < slides.length; i++) {
        var slide = slides.item(i) as HTMLElement;
        slide.style.display = i == index ? 'block' : 'none';
      }
    }

    prevButton?.onclick = (MouseEvent e) {
      currentIndex = (currentIndex > 0) ? currentIndex - 1 : slides.length - 1;
      showSlide(currentIndex);
    }.toJS;

    nextButton?.onclick = (MouseEvent e) {
      currentIndex = (currentIndex < slides.length - 1) ? currentIndex + 1 : 0;
      showSlide(currentIndex);
    }.toJS;

    if (slides.length > 0) {
      showSlide(currentIndex);
    }
  }

  // Recent Posts logic
  var recentPostsContainer = document.getElementById('recent-posts-container');
  if (recentPostsContainer != null) {
    var blogUrl = 'https://${window.location.hostname}';
    var feedUrl = '$blogUrl/feeds/posts/default?alt=json-in-script&max-results=5';

    window.fetch(feedUrl.toJS).toDart.then((response) {
      return (response as Response).text().toDart;
    }).then((text) {
      var body = (text as JSString).toDart;
      var jsonStart = body.indexOf('{');
      var jsonEnd = body.lastIndexOf('}');
      if (jsonStart != -1 && jsonEnd != -1) {
        var jsonStr = body.substring(jsonStart, jsonEnd + 1);
        var data = jsonDecode(jsonStr);
        var entries = data['feed']['entry'] as List? ?? [];

        var html = '<ul>';
        for (var entry in entries) {
          var postTitle = entry['title']['\$t'];
          var links = entry['link'] as List;
          var postLink = links.firstWhere((l) => l['rel'] == 'alternate')['href'];
          html += '<li><a href="$postLink">$postTitle</a></li>';
        }
        html += '</ul>';
        (recentPostsContainer as HTMLElement).innerHTML = html.toJS;
      }
    });
  }

  // Other logic
  var body = document.querySelector('body') as HTMLElement?;
  if (body != null) {
    var div = document.createElement('div') as HTMLDivElement;
    div.innerText = 'Dart compiled JS is running!';
    div.style.backgroundColor = 'rgba(255, 255, 0, 0.5)';
    div.style.padding = '5px';
    div.style.position = 'fixed';
    div.style.bottom = '0';
    div.style.right = '0';
    body.appendChild(div);
  }
}
