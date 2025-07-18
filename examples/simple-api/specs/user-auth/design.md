# Technical Design: User Authentication

## Architecture Overview

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Client    │────▶│  API Server │────▶│  Database   │
│  (Frontend) │     │  (Express)  │     │ (PostgreSQL)│
└─────────────┘     └─────────────┘     └─────────────┘
       │                    │                    │
       │   POST /register   │                    │
       │───────────────────▶│                    │
       │                    │   INSERT user      │
       │                    │───────────────────▶│
       │                    │                    │
       │   200 OK + token   │                    │
       │◀───────────────────│                    │
```

## Technology Stack

- **Language**: TypeScript/Node.js
- **Framework**: Express.js
- **Database**: PostgreSQL
- **Authentication**: JWT (jsonwebtoken)
- **Password Hashing**: bcrypt
- **Validation**: express-validator

## Data Model

### Users Table

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT true,
    failed_login_attempts INTEGER DEFAULT 0,
    locked_until TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
```

### Refresh Tokens Table

```sql
CREATE TABLE refresh_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token VARCHAR(255) UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_refresh_tokens_user_id ON refresh_tokens(user_id);
CREATE INDEX idx_refresh_tokens_token ON refresh_tokens(token);
```

## API Design

### POST /api/auth/register

Request:
```json
{
  "email": "user@example.com",
  "username": "johndoe",
  "password": "SecurePassword123!"
}
```

Response (Success - 201):
```json
{
  "user": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "email": "user@example.com",
    "username": "johndoe"
  },
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "7f8a9b1c2d3e4f5g6h7i8j9k0"
}
```

Response (Error - 400):
```json
{
  "error": "Validation failed",
  "details": [
    {
      "field": "email",
      "message": "Email already exists"
    }
  ]
}
```

### POST /api/auth/login

Request:
```json
{
  "email": "user@example.com",
  "password": "SecurePassword123!"
}
```

Response (Success - 200):
```json
{
  "user": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "email": "user@example.com",
    "username": "johndoe"
  },
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "7f8a9b1c2d3e4f5g6h7i8j9k0"
}
```

Response (Error - 401):
```json
{
  "error": "Invalid credentials"
}
```

### POST /api/auth/refresh

Request:
```json
{
  "refreshToken": "7f8a9b1c2d3e4f5g6h7i8j9k0"
}
```

Response (Success - 200):
```json
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "new-refresh-token"
}
```

## Security Considerations

### Password Hashing
```javascript
const bcrypt = require('bcrypt');
const SALT_ROUNDS = 10;

// Hashing
const hash = await bcrypt.hash(password, SALT_ROUNDS);

// Verification
const isValid = await bcrypt.compare(password, hash);
```

### JWT Configuration
```javascript
const jwt = require('jsonwebtoken');

// Token generation
const token = jwt.sign(
  { userId: user.id, email: user.email },
  process.env.JWT_SECRET,
  { expiresIn: '24h' }
);

// Token verification
const decoded = jwt.verify(token, process.env.JWT_SECRET);
```

### Rate Limiting
```javascript
const rateLimit = require('express-rate-limit');

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 requests
  message: 'Too many login attempts, please try again later'
});

app.post('/api/auth/login', loginLimiter, loginHandler);
```

### Input Validation
```javascript
const { body, validationResult } = require('express-validator');

const registerValidation = [
  body('email').isEmail().normalizeEmail(),
  body('username').isLength({ min: 3, max: 20 }).isAlphanumeric(),
  body('password').isLength({ min: 8 }).isStrongPassword()
];
```

## Error Handling

All errors follow this format:
```json
{
  "error": "Error type",
  "message": "Human-readable message",
  "details": [] // Optional validation details
}
```

Error codes:
- 400: Bad Request (validation errors)
- 401: Unauthorized (invalid credentials)
- 403: Forbidden (account locked)
- 429: Too Many Requests (rate limit)
- 500: Internal Server Error

## Testing Strategy

### Unit Tests
- Password hashing functions
- JWT generation and verification
- Input validation rules
- Business logic functions

### Integration Tests
- Registration endpoint with various inputs
- Login endpoint with valid/invalid credentials
- Token refresh flow
- Rate limiting behavior

### Security Tests
- SQL injection attempts
- XSS payload testing
- Brute force protection
- Token manipulation attempts

## Performance Considerations

- Database connection pooling
- Indexed email and username fields
- Async/await for all database operations
- Caching for frequently accessed user data

## Monitoring

- Log all authentication attempts
- Track failed login patterns
- Monitor token generation rates
- Alert on suspicious activities