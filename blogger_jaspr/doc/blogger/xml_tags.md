# Blogger XML Tags Reference

This document covers the essential XML tags used in Blogger Layouts (Version 3).

## Page Elements

### `<b:section>`
Containers for widgets.
- **Attributes**:
  - `id` (Required): Unique alphanumeric ID.
  - `class`: Common names: `navbar`, `header`, `main`, `sidebar`, `footer`.
  - `maxwidgets`: Max number of widgets allowed.
  - `showaddelement`: `yes` (default) or `no`.
  - `growth`: `vertical` (default) or `horizontal`.
  - `preferred`: `yes` or `no`.

### `<b:widget>`
Placeholders for dynamic content.
- **Attributes**:
  - `id` (Required): Unique alphanumeric ID.
  - `type` (Required): `Header`, `Blog`, `Profile`, `LinkList`, `AdSense`, `HTML`, etc.
  - `locked`: `yes` or `no` (default).
  - `title`: Display title.
  - `pageType`: `all` (default), `archive`, `main`, `item`.
  - `mobile`: `yes`, `no`, `only`, `default`.

## Logic & Control Flow

### `<b:if>`, `<b:elseif/>`, `<b:else/>`
Conditional rendering.
```xml
<b:if cond='data:view.isHomepage'>
  <!-- Homepage only content -->
<b:elseif cond='data:view.isPost'/>
  <!-- Post only content -->
<b:else/>
  <!-- Other pages -->
</b:if>
```

### `<b:switch>`, `<b:case/>`, `<b:default/>`
Switch-case logic.
```xml
<b:switch var='data:blog.pageType'>
  <b:case value="static_page" />
    <h1>Page</h1>
  <b:default />
    <h2>Posts</h2>
</b:switch>
```

### `<b:loop>`
Iterate over lists.
- **Attributes**:
  - `values`: The data list.
  - `var`: Variable name for the item.
  - `index`: (Optional) Zero-based index variable.
```xml
<b:loop values='data:posts' var='post' index='i'>
  <li>Index: <data:i/> - <data:post.title/></li>
</b:loop>
```

## Reusability

### `<b:includable>` & `<b:include>`
Define and call reusable blocks.
```xml
<b:includable id='main'>
  <b:include name='sub-content' data='data:blog.title'/>
</b:includable>

<b:includable id='sub-content' var='title'>
  Title is: <data:title/>
</b:includable>
```

## Styling

### `<b:skin>` & `<b:template-skin>`
Contains CSS. `<b:skin>` supports Variable definitions for the Template Designer.
```xml
<b:skin><![CDATA[
/*
 * Variable definitions:
 <Variable name="bgcolor" description="Background" type="color" default="#fff"/>
 */
 body { background: $bgcolor; }
]]></b:skin>
```

## Other Tags
- `<b:eval expr='...'/>`: Evaluate complex expressions.
- `<b:with var='name' value='...'/>`: Temporary variable alias.
- `<b:message name='...'/>`: Localized messages.
- `<b:attr name='...' value='...'/>`: Dynamic attributes.
- `<b:class name='...' cond='...'/>`: Conditional CSS classes.
- `<b:tag name='...' cond='...'/>`: Dynamic tag names.
- `<b:comment>`: Blogger-specific XML comments.

## References
- [Official Blogger Help: Layouts Tags](https://support.google.com/blogger/answer/46888)
- [Official Blogger Help: Widget Tags](https://support.google.com/blogger/answer/46995)
