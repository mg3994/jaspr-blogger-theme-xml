# Blogger Troubleshooting

Common errors encountered when developing and uploading Blogger themes.

## 1. `TemplateFormatException: template-skin only available for templates version 2 and above`
- **Cause**: You are using `<b:template-skin>` but your `<html>` tag lacks the necessary version attributes.
- **Fix**: Ensure your `Html` component includes `b:layoutsversion='3'` and `b:defaultwidgetversion='2'`. The `blogger_jaspr` `Html` component does this by default.

## 2. `The widget with id "..." cannot contain element: "b:if"`
- **Cause**: You placed logic tags (if, loop, div) directly inside a `<b:widget>`.
- **Fix**: All widget logic must be wrapped inside a `<b:includable id='main'>` tag.

## 3. `Attribute "expr:..." is not allowed here`
- **Cause**: You are using an expression attribute on a tag or in a context where Blogger doesn't support it, or the syntax is malformed.
- **Fix**: Check that the expression is correctly quoted and that the base attribute (without `expr:`) is a valid HTML attribute for that tag.

## 4. `Variable "..." is not defined`
- **Cause**: You are using `$varname` in your CSS but haven't defined it in the `<b:skin>` Variable definitions block.
- **Fix**: Add the corresponding `<Variable/>` tag inside the `/* Variable definitions: ... */` comment in your `BSkin`.

## 5. XML Validation Errors on Upload
- **Illegal Characters**: If you have `&`, `<`, or `>` in your JavaScript or attributes, Blogger will reject the file.
- **Fix**: `blogger_jaspr` automatically escapes these characters in `Text` and `Script` components. If you are using `RawText`, you must handle escaping manually.
- **CDATA Usage**: Remember that Blogger only allows CDATA inside `<b:skin>` and `<b:template-skin>`. Using it in `<script>` tags will often cause errors.
