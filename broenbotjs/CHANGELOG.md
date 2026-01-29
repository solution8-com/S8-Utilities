# Changelog

## Unreleased
- ensure webhook text is stripped of any `<verbatim>` tags before we parse it so the message renderer stays stable.
- sanitize the chat textarea before we send it (newline sequences become single spaces and extra whitespace is collapsed) so the webhook never receives empty/multiline input that causes the backend to drop the response.
