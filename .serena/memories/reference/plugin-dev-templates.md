# Plugin-Dev Templates (saved before reference/ removal)

## plugin.json.template
```json
{
  "name": "{{plugin-name}}",
  "version": "0.1.0",
  "description": "{{Brief description of plugin purpose}}",
  "author": {
    "name": "{{Author Name}}",
    "email": "{{author@example.com}}"
  },
  "keywords": [
    "{{keyword1}}",
    "{{keyword2}}"
  ],
  "license": "MIT"
}
```

## marketplace.json.template
```json
{
  "$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
  "name": "{{plugin-name}}-marketplace",
  "version": "0.1.0",
  "description": "Marketplace for {{plugin-name}} plugin",
  "owner": {
    "name": "{{Owner Name}}",
    "email": "{{owner@example.com}}"
  },
  "plugins": [
    {
      "name": "{{plugin-name}}",
      "description": "{{Brief description}}",
      "version": "0.1.0",
      "author": {
        "name": "{{Author Name}}",
        "email": "{{author@example.com}}"
      },
      "source": "./",
      "category": "{{developer-tools|productivity|integration|security}}",
      "keywords": ["{{keyword1}}"],
      "license": "MIT"
    }
  ]
}
```
