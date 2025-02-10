# Secure Authentication System

A production-ready authentication system built with React and Node.js, implementing modern security best practices.

## 🚀 Features

### Security
- ✅ CSRF Protection with Double Submit Cookie Pattern
- ✅ HTTP-Only Cookies for JWT Storage
- ✅ Secure Password Hashing with bcrypt
- ✅ Rate Limiting for Brute Force Prevention
- ✅ Input Validation & Sanitization
- ✅ Secure Session Management
- ✅ XSS Protection with React's Built-in Escaping
- ✅ Configurable CORS Settings

### User Experience
- 🎯 Clean, Modern UI
- 🎯 Responsive Design
- 🎯 Form Validation
- 🎯 Error Handling
- 🎯 Loading States
- 🎯 Session Management

## 🛠️ Technical Stack

### Frontend
- React
- Modern JavaScript (ES6+)
- Fetch API for Network Requests
- CSS3 with Modern Features

### Backend
- Node.js
- Express.js
- JWT for Authentication
- bcrypt for Password Hashing
- Express Rate Limit
- CORS
- Cookie Parser
- CSRF Protection

## 🏗️ Architecture

The system uses a three-tier architecture:
1. **Frontend (React)**: Handles UI and user interactions
2. **Auth Server**: Manages authentication and security
3. **Backend Server**: Handles business logic and data

## 🔒 Security Features Explained

### CSRF Protection
- Implements Double Submit Cookie Pattern
- Validates CSRF tokens on all authenticated requests
- Automatically refreshes tokens

### JWT Implementation
- Tokens stored in HTTP-Only cookies
- Automatic token refresh mechanism
- Secure token validation

### Password Security
- Strong password requirements enforcement
- Secure hashing with bcrypt
- Protection against common password attacks

## 🚀 Getting Started

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn
- Modern web browser

### Installation

1. Clone the repository:
```bash
git clone [your-repo-url]
```

2. Install dependencies:
```bash
# Frontend
cd server-frontend
npm install

# Auth Server
cd server-auth
npm install
```

3. Set up environment variables:
```bash
# Auth Server (.env)
JWT_SECRET=your_jwt_secret
PORT=3001

# Frontend (.env)
REACT_APP_AUTH_URL=http://localhost:3001
REACT_APP_API_URL=http://localhost:3002
```

4. Start the servers:
```bash
# Start Auth Server
cd server-auth
npm start

# Start Frontend
cd server-frontend
npm start
```

## 📚 API Documentation

### Authentication Endpoints

#### POST /auth/register
- Creates new user account
- Requires: email, password, name
- Returns: Success message

#### POST /auth/login
- Authenticates user
- Requires: email, password
- Returns: JWT token in HTTP-only cookie

#### POST /auth/logout
- Ends user session
- Clears authentication cookies

#### GET /csrf-token
- Provides CSRF token for form submissions
- Required for all authenticated requests

## 🔍 Code Quality

- ESLint for code quality
- Prettier for code formatting
- Jest for testing
- Security best practices enforcement

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔐 Security Considerations

- Regular security audits recommended
- Keep dependencies updated
- Monitor for suspicious activities
- Implement proper logging in production

## 🌟 Best Practices

- Regular token rotation
- Secure password requirements
- Rate limiting on sensitive endpoints
- Input validation on all user data
- Proper error handling
- Secure session management

## 📈 Future Enhancements

- Two-factor authentication
- OAuth integration
- Password reset functionality
- Account deletion
- Session management dashboard
- Security event logging

## 🧪 Testing

### Quick Start Testing
Want to test if everything is working? Just run:
```bash
# 1. Make the script executable (one-time setup)
chmod +x scripts/test-auth.sh

# 2. Run the tests
./scripts/test-auth.sh
```

You'll see a colorful output showing each step:
- 🔑 Getting CSRF Token
- 👤 Registering a test user
- 🔓 Logging in
- 🔒 Logging out

### Test Credentials
The script uses these default test credentials:
```
Email: test@example.com
Password: TestPassword123
Name: Test User
```

### What's Being Tested?
1. **CSRF Protection**
   - Fetches CSRF token
   - Includes token in requests
   - Validates token handling

2. **User Management**
   - Creates new user account
   - Validates login credentials
   - Handles logout properly

3. **Security Features**
   - HTTP-Only cookies
   - Secure session handling
   - Token management

### Troubleshooting
If the tests fail, check:
1. Is the auth server running? (should be on port 3001)
2. Are all environment variables set?
3. Check the logs in `server-auth/logs/` for details

### Manual Testing
You can also test manually using tools like:
- The web interface at http://localhost:3003
- Postman (API collection included in `/docs`)
- curl commands (examples below)

#### Example curl Commands
```bash
# Get CSRF Token
curl -v -c cookies.txt -b cookies.txt http://localhost:3001/csrf-token

# Register (replace TOKEN with your CSRF token)
curl -v -X POST \
  -c cookies.txt -b cookies.txt \
  -H "Content-Type: application/json" \
  -H "X-CSRF-Token: TOKEN" \
  -d '{"email":"test@example.com","password":"TestPassword123","name":"Test User"}' \
  http://localhost:3001/auth/register
```

---

Built with ❤️ by Osman aka bendarte