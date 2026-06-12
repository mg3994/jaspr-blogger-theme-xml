# Blogger Best Practices

Guidelines for creating professional, fast, and SEO-friendly Blogger themes.

## 1. Layout Hierarchy
Always respect the logical hierarchy of Blogger tags to avoid dashboard errors:
- `b:section` is the top-level container in `body`.
- `b:widget` must be a direct child of `b:section`.
- `b:includable` must be a direct child of `b:widget`.
- One `b:includable` must have `id='main'`.

## 2. Performance & Images
- **Resize on the fly**: Never load full-size images for thumbnails. Use `resizeImage(url, size, ratio)`.
- **Lazy Loading**: Use the native `loading="lazy"` attribute for images below the fold.
- **Minimize JS**: Keep client-side scripts lightweight. Prefer CSS for animations where possible.

## 3. SEO Optimization
- **Dynamic Titles**: Use `<title><data:blog.pageTitle/></title>` to ensure search engines see unique titles for every post.
- **Meta Tags**: Include essential meta tags in the `<head>` using `<b:include data='blog' name='all-head-content'/>`.
- **Semantic HTML**: Use proper `<header>`, `<nav>`, `<main>`, and `<footer>` tags around your Blogger sections.

## 4. Accessibility (a11y)
- **Alt Text**: Always provide alt text for thumbnails: `<img expr:alt='data:post.title' .../>`.
- **Form Labels**: Ensure search inputs have associated labels or `aria-label` attributes.
- **Contrast**: Maintain high color contrast for readability, especially if using Template Designer variables.

## 5. Development Workflow
- **Comments**: Use `<b:comment>` for notes that stay in the XML and `XmlComment` for notes that are stripped or formatted.
- **Version Control**: Keep your Dart source code in Git, and treat the generated `.xml` as a build artifact.
