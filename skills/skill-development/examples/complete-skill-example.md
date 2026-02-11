# Complete Skill Example

This example shows a fully-featured skill with SKILL.md, references/, examples/, and scripts/ directories. This is the pattern used by hook-development and other complex skills in plugin-dev.

## Directory Structure

```
api-testing/
├── SKILL.md
├── references/
│   ├── test-patterns.md
│   ├── mocking-strategies.md
│   └── assertion-guide.md
├── examples/
│   ├── basic-get-test.js
│   ├── post-with-auth.js
│   └── mock-external-api.js
└── scripts/
    ├── run-api-tests.sh
    ├── validate-openapi.sh
    └── README.md
```

## When to Use This Pattern

Use complete skills when:
- Domain is complex with multiple aspects
- Need validation or automation utilities
- Multiple reference guides needed
- Want to provide comprehensive tooling
- Users perform same operations repeatedly

## Example: api-testing/SKILL.md

```markdown
---
name: API Testing
description: This skill should be used when the user asks to "test an API", "write API tests", "mock external services", "validate API responses", or needs guidance on API testing strategies.
version: 0.1.0
---

# API Testing

This skill provides comprehensive guidance for testing REST APIs.

## Overview

API testing validates that endpoints return correct data, handle errors properly, and maintain expected behavior. This skill covers test patterns, mocking strategies, and validation utilities.

## Quick Start

To test an API endpoint:
1. Identify the endpoint and expected behavior
2. Choose appropriate test pattern (see `references/test-patterns.md`)
3. Write test using examples as templates
4. Mock external dependencies if needed
5. Run tests with validation scripts

## Test Patterns

### Basic GET Request Test

See `examples/basic-get-test.js` for complete implementation.

```javascript
test('GET /users returns user list', async () => {
  const response = await request(app).get('/users');
  expect(response.status).toBe(200);
  expect(Array.isArray(response.body)).toBe(true);
});
```

### POST with Authentication

See `examples/post-with-auth.js` for complete implementation with JWT handling.

### Mocking External APIs

See `examples/mock-external-api.js` for mocking patterns.

For advanced mocking strategies, consult `references/mocking-strategies.md`.

## Validation Utilities

Use provided scripts for common operations:

- **`scripts/run-api-tests.sh`** - Run all API tests with proper setup
- **`scripts/validate-openapi.sh`** - Validate OpenAPI specifications

See `scripts/README.md` for usage details.

## Best Practices

- Test happy paths and error cases
- Mock external dependencies
- Use factories for test data
- Validate response schemas
- Test authentication and authorization
- Check rate limiting
- Verify CORS headers

## Additional Resources

### Reference Files

Detailed guides for various testing aspects:
- **`references/test-patterns.md`** - Common API test patterns
- **`references/mocking-strategies.md`** - How to mock external services
- **`references/assertion-guide.md`** - Comprehensive assertion patterns

### Example Files

Working test examples you can adapt:
- **`examples/basic-get-test.js`** - Simple GET request test
- **`examples/post-with-auth.js`** - POST with JWT authentication
- **`examples/mock-external-api.js`** - Mocking external API calls

### Utility Scripts

Automation and validation tools:
- **`scripts/run-api-tests.sh`** - Test runner with environment setup
- **`scripts/validate-openapi.sh`** - OpenAPI spec validator
- **`scripts/README.md`** - Script usage documentation
```

## Example: scripts/run-api-tests.sh

```bash
#!/bin/bash
# Run API tests with proper environment setup

set -euo pipefail

# Load test environment
export NODE_ENV=test
export API_BASE_URL=${API_BASE_URL:-http://localhost:3000}

# Ensure test database is ready
echo "Setting up test database..."
npm run db:test:reset

# Run tests
echo "Running API tests..."
npm test -- --testPathPattern=api

# Cleanup
echo "Cleaning up..."
npm run db:test:teardown

echo "✅ API tests complete"
```

## Example: scripts/README.md

```markdown
# API Testing Scripts

## run-api-tests.sh

Runs API tests with proper environment setup and cleanup.

**Usage:**
```bash
./scripts/run-api-tests.sh
```

**Environment variables:**
- `API_BASE_URL` - Base URL for API (default: http://localhost:3000)

## validate-openapi.sh

Validates OpenAPI specification files for correctness.

**Usage:**
```bash
./scripts/validate-openapi.sh path/to/openapi.yaml
```

**Requirements:**
- openapi-validator (install: `npm install -g openapi-validator`)
```

## Example: references/test-patterns.md

```markdown
# API Test Patterns

## Pattern 1: Happy Path Testing

Test that endpoints return expected data for valid requests.

```javascript
describe('User API', () => {
  test('GET /users/:id returns user', async () => {
    const user = await factory.create('user');
    const response = await request(app).get(`/users/${user.id}`);

    expect(response.status).toBe(200);
    expect(response.body.id).toBe(user.id);
    expect(response.body.email).toBe(user.email);
  });
});
```

## Pattern 2: Error Case Testing

Test that endpoints handle errors gracefully.

```javascript
describe('Error Handling', () => {
  test('GET /users/:id returns 404 for non-existent user', async () => {
    const response = await request(app).get('/users/99999');

    expect(response.status).toBe(404);
    expect(response.body.error).toBe('User not found');
  });

  test('POST /users returns 400 for invalid data', async () => {
    const response = await request(app)
      .post('/users')
      .send({ email: 'invalid-email' });

    expect(response.status).toBe(400);
    expect(response.body.errors).toContain('Invalid email');
  });
});
```

[... 8 more patterns with detailed examples ...]
```

## Characteristics

- **SKILL.md**: ~600 words (focused core)
- **references/**: 3 files, 2,000+ words each (comprehensive guides)
- **examples/**: 3 working code files (copy-paste ready)
- **scripts/**: 2 utilities + README (automation tools)
- **Full progressive disclosure**: Load exactly what's needed
- **Production-ready utilities**: Deterministic validation

## Benefits

✅ Comprehensive coverage of domain
✅ Working examples for every pattern
✅ Validation utilities for quality
✅ Progressive disclosure at scale
✅ Automation reduces repetitive work
✅ Scripts can run without loading into context
✅ Excellent for complex domains

## When NOT to Use

This pattern is overkill when:
- Domain is simple (use minimal pattern)
- No validation needed
- No repetitive scripts
- Just need basic documentation (use standard pattern)

## Real Examples in plugin-dev

Study these complete skills:
- **hook-development**: 3 references, 3 examples, 4 scripts
- **agent-development**: 3 references, 2+ examples, 1+ scripts
- **plugin-settings**: 2 references, 3 examples, 2 scripts

Each demonstrates how to organize complex domains with progressive disclosure and practical utilities.
