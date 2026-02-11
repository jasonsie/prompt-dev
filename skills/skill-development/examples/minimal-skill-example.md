# Minimal Skill Example

This example shows the simplest possible skill structure - just a SKILL.md file with no additional resources.

## Directory Structure

```
api-basics/
└── SKILL.md
```

## When to Use This Pattern

Use minimal skills when:
- The knowledge is simple and self-contained
- No scripts, examples, or detailed references needed
- Total content fits comfortably under 2,000 words
- Domain doesn't require complex resources

## Example: api-basics/SKILL.md

```markdown
---
name: API Basics
description: This skill should be used when the user asks about "REST API", "API design", "HTTP methods", "API endpoints", or needs basic API development guidance.
version: 0.1.0
---

# API Basics

This skill provides fundamental guidance for working with REST APIs.

## Core Concepts

### HTTP Methods

- **GET**: Retrieve data
- **POST**: Create new resources
- **PUT**: Update existing resources
- **DELETE**: Remove resources
- **PATCH**: Partial updates

### Response Codes

- **2xx**: Success
  - 200 OK
  - 201 Created
  - 204 No Content
- **4xx**: Client errors
  - 400 Bad Request
  - 401 Unauthorized
  - 404 Not Found
- **5xx**: Server errors
  - 500 Internal Server Error
  - 503 Service Unavailable

### Best Practices

When designing APIs:
- Use nouns for resource endpoints (/users, not /getUsers)
- Use HTTP methods appropriately
- Return proper status codes
- Version your APIs (/v1/users)
- Document all endpoints

### Example Endpoint Design

```
GET    /api/v1/users       - List users
POST   /api/v1/users       - Create user
GET    /api/v1/users/:id   - Get specific user
PUT    /api/v1/users/:id   - Update user
DELETE /api/v1/users/:id   - Delete user
```

## Implementation Guidelines

To implement a REST API endpoint:
1. Define the resource (user, product, etc.)
2. Choose appropriate HTTP method
3. Design the URL structure
4. Define request/response format
5. Handle errors appropriately
6. Document the endpoint
```

## Characteristics

- **Length**: ~300 words
- **Self-contained**: All information in one file
- **No external resources**: Everything needed is included
- **Quick to load**: Minimal context impact
- **Easy to maintain**: Single file to update

## Limitations

- Not suitable for complex domains
- Can't leverage progressive disclosure
- No working code examples
- No validation utilities
- Limited depth possible
