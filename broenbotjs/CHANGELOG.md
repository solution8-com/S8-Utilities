# Changelog

## Unreleased
- ensure webhook text is stripped of any `<verbatim>` tags before parsing so the renderer stays stable.
- sanitize the chat textarea before sending (newline sequences become single spaces) so the webhook never receives empty/multiline input that causes the backend to drop the response.
- remove the stale `chat.bundle.es.js` copy to keep repo diffs focused on the maxified source we maintain directly.
