# Blogger Data Tags Reference

Data tags allow you to pull dynamic information into your theme. They always start with `data:`.

## Global Blog Data
Available anywhere in the theme. Use prefix `data:blog.`.

| Tag | Description |
|---|---|
| `title` | The blog's title. |
| `pageType` | `item`, `archive`, or `index`. |
| `url` | URL of the current page. |
| `homepageUrl` | Main blog URL. |
| `pageTitle` | Page title (usually Blog Title + Context). |
| `encoding` | Character encoding (e.g. UTF-8). |
| `languageDirection` | `ltr` or `rtl`. |

## View Data
Current view context. Use prefix `data:view.`.

| Tag | Description |
|---|---|
| `isHomepage` | True on the main homepage. |
| `isPost` | True on single post pages. |
| `isPage` | True on static pages. |
| `isSearch` | True on search result pages. |
| `isError` | True on 404 pages. |
| `isArchive` | True on archive pages. |

## Widget-Specific Data

### Blog Posts (`Blog` Widget)
- `posts`: List of post objects.
  - `title`, `body`, `author`, `url`, `timestamp`.
  - `labels`: List of label objects (`name`, `url`, `isLast`).
  - `thumbnailUrl`: First image in the post.
- `olderPageUrl` / `newerPageUrl`: Pagination links.

### Profile Widget
- `aboutme`: Author bio.
- `displayname`: Author name.
- `photo`: Object with `url`, `width`, `height`, `alt`.

### Link List Widget
- `links`: List of objects with `name`, `target`.

## Expressions (`expr:`)
Use to set attributes dynamically.
```xml
<a expr:href='data:blog.homepageUrl'>Home</a>
```

## Resizing Images
`resizeImage(imageUrl, newSize, optionalRatio, optionalCrop)`
```xml
<img expr:src='resizeImage(data:post.thumbnailUrl, 300, "1:1")'/>
```

## References
- [Official Blogger Help: Layouts Data Tags](https://support.google.com/blogger/answer/47270)
