# Blogger Customization Guides

Best practices for common theme features.

## Custom 404 Page
Blogger handles 404s by injecting a custom message into your main theme.
1. Set message in: `Settings -> Errors and redirects -> Custom 404`.
2. Use conditional in theme:
```xml
<b:if cond='data:view.isError'>
  <div class='error-page'>
    <h1>404 - Not Found</h1>
    <data:navMessage/>
  </div>
</b:if>
```

## Dynamic Search
Search logic is handled via `/search?q=query`.
```xml
<form class='search-form' expr:action='data:blog.homepageUrl + "search"'>
  <input name='q' type='text' placeholder='Search...'/>
  <button type='submit'>Go</button>
</form>
```

## Feeds (Atom & RSS)
- **Full Feed**: `feeds/posts/default`
- **Summary Feed**: `feeds/summary`
- **RSS Format**: Append `?alt=rss`

## Interactive Components (Sliders)
Since Blogger is server-side rendered, use JavaScript to handle interactivity.
1. Render post data into a hidden container or data attributes using `<b:loop>`.
2. Use JS to cycle through visibility.
3. For best performance, use `resizeImage` to load only the required thumbnail sizes.

## Template Designer
Define variables in `<b:skin>` to allow users to change colors and fonts via the UI.
```css
/*
 * Variable definitions:
 <Variable name="mainColor" description="Main Theme Color" type="color" default="#ff0000"/>
 */
 a { color: $mainColor; }
```
