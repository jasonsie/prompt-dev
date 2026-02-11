# Standard Skill Example

This example shows the recommended skill structure for most plugin skills - SKILL.md with references/ and examples/ directories.

## Directory Structure

```
database-migrations/
├── SKILL.md
├── references/
│   └── migration-patterns.md
└── examples/
    ├── create-table.sql
    └── add-column.sql
```

## When to Use This Pattern

Use standard skills when:
- Need to provide detailed documentation beyond core content
- Have working code examples users can copy
- Domain has moderate complexity
- Want to implement progressive disclosure
- Don't need validation utilities (yet)

## Example: database-migrations/SKILL.md

```markdown
---
name: Database Migrations
description: This skill should be used when the user asks to "create a migration", "modify database schema", "add database column", "create table", or needs guidance on database migration patterns.
version: 0.1.0
---

# Database Migrations

This skill provides guidance for creating and managing database migrations.

## Overview

Database migrations are version-controlled schema changes that allow teams to evolve database structure safely. Each migration represents a discrete change and can be applied or rolled back.

## Core Workflow

To create a migration:
1. Identify the schema change needed
2. Create a new migration file with timestamp
3. Write the "up" migration (apply change)
4. Write the "down" migration (rollback)
5. Test both directions
6. Commit to version control

## Migration File Naming

Use timestamp-based naming:
```
20240115120000_create_users_table.sql
20240115120100_add_email_to_users.sql
```

Format: `YYYYMMDDHHMMSS_description.sql`

## Common Operations

### Creating Tables

See `examples/create-table.sql` for a complete example.

Key considerations:
- Define primary keys
- Add indexes for query performance
- Set NOT NULL constraints appropriately
- Use foreign keys for relationships

### Adding Columns

See `examples/add-column.sql` for a complete example.

Important:
- Provide default values for NOT NULL columns
- Consider impact on existing data
- Update application code simultaneously

### Modifying Columns

Approach depends on database system. Consult `references/migration-patterns.md` for database-specific guidance.

## Best Practices

- Never modify existing migrations
- Test rollbacks before deploying
- Keep migrations focused (one logical change)
- Add indexes in separate migrations
- Document complex changes

## Additional Resources

### Reference Files

For detailed patterns and database-specific guidance:
- **`references/migration-patterns.md`** - Patterns for PostgreSQL, MySQL, SQLite

### Example Files

Working migration examples:
- **`examples/create-table.sql`** - Creating a table with indexes
- **`examples/add-column.sql`** - Adding a column safely
```

## Example: references/migration-patterns.md

```markdown
# Database Migration Patterns

## PostgreSQL Patterns

### Adding Columns with Defaults

```sql
-- Safe approach for large tables
ALTER TABLE users ADD COLUMN status VARCHAR(20);
UPDATE users SET status = 'active' WHERE status IS NULL;
ALTER TABLE users ALTER COLUMN status SET DEFAULT 'active';
ALTER TABLE users ALTER COLUMN status SET NOT NULL;
```

### Creating Indexes Concurrently

```sql
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);
```

## MySQL Patterns

### Modifying Column Types

```sql
ALTER TABLE users MODIFY COLUMN age INT UNSIGNED;
```

[... more detailed patterns ...]
```

## Example: examples/create-table.sql

```sql
-- Create users table with proper constraints and indexes
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_created_at ON users(created_at);
```

## Characteristics

- **SKILL.md**: ~500 words (core essentials)
- **references/**: 1,500+ words (detailed patterns)
- **examples/**: Working code users can copy
- **Progressive disclosure**: Details load only when needed
- **Practical**: Balance of theory and practice

## Benefits

✅ Implements progressive disclosure
✅ Provides working examples
✅ Keeps SKILL.md focused
✅ Detailed docs available when needed
✅ Easy to extend (add more references/examples)
✅ Good for most plugin skills
