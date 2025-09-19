# Transcendence — Real‑Time Multiplayer Game Platform

> **Aether Arena / Transcendence** — A real‑time online multiplayer Pong‑style platform built with a microservice architecture.

🎮 **Demo & Preview**
- Video Demo (YouTube): https://www.youtube.com/watch?v=GUWTqCiNAI0
- Play Online: https://www.aetherarena.art

---

## Overview
Transcendence is a **full‑stack online web game** developed by a team of 5. It delivers a scalable, and secure gameplay experience. The project leverages microservices and WebSocket real‑time communication. The frontend is powered by TailwindCSS Babylon.js for in‑browser 3D rendering, supporting local matches, AI practice, online duels, and tournament mode. It also includes a complete user system, match history, leaderboard, and friend management.

---

## Highlights
- **User friendly UI / UX design**: Intuitive UI and UX design, 3D stage, to ensure the best user experience.
- **Comprehensive Account System**: Full account management (create, update, delete), friend interactions, and access to friends’ game history and records.
- **Real‑time Multiplayer**: Smooth gameplay powered by WebSocket communication.
- **Microservice Architecture**: Services split into Client, User, Game Engine, Friend, Record, and Message Broker, using RestAPI to communicate between servers.
- **3D Rendering**: Interactive game stages built with Babylon.js.
- **Secure Authentication**: Google OAuth2, 2FA, and JWT session management.
- **Containerized Deployment**: Docker & NGINX for reverse proxy, SSL termination, and load balancing.
- **Production Ready**: Production flag disables client logs; optional preset accounts for testing.
- **Real-time message**: System for friend status, game rank updates, and invitations, implemented with backend caching and efficient polling.
- **Scalable game server**: Game logic runs on independent, horizontally scalable servers, establishing WebSocket connections only when necessary.
- **Game AI**: Runs on the client side, simulating human-like behavior to ensure a fair and balanced match experience

---

## UI / UX
Repository includes demo screenshots in `doc/`:

![Login demo](doc/login.png)

![Main page](doc/main.png)

![Game demo](doc/stage1.png)

![Game demo](doc/stage2.png)

![Tournament](doc/tournament.png)

![Game record](doc/record.png)

---

## Features
- Account management with Google OAuth2 login
- Two‑Factor Authentication (2FA) via QR code
- JWT session management
- Avatar upload & profile editing
- Friend management with real‑time status
- Local play vs AI, local 2‑player mode
- Online multiplayer (1v1) & tournament mode
- Game history & leaderboard
- Disconnection handling & reconnection
- Protection against SQL injection & XSS

---

## Tech Stack
### Architecture
![System Architecture](doc/ft_transcendence.jpg)
- **Microservices**: Decoupled services (Client, User, Game Engine, Friend, Record, Message Broker)
- **Message Broker**: RESTAPI communication between services
- **NGINX**: API gateway, reverse proxy, SSL termination, static assets, load balancing

### Frontend
- **HTML + TypeScript + Tailwind CSS**
- **Babylon.js**: 3D rendering and interactive gameplay
- **WebSocket (wss)**: Low‑latency real‑time communication
- **Custom Game AI**: For offline and training mode

### Backend
- **Node.js + Fastify**: High‑performance web framework
- **Microservices**:
  - `client`: Frontend delivery, Reverse proxy, Load balancing
  - `user`: Authentication & account management
  - `game-engine`: Game sessions, matchmaking, frame synchronization
  - `friend`: Friend system & status updates
  - `record`: Game history & ranking
  - `message broker`: Event/message handling
- **Database**: SQLite (better‑sqlite3). Each service has its own database.
- **Authentication**: OAuth2 (Google), 2FA (QR code), JWT for cross‑service session management, strong password policy with salted hash password storage

### Infrastructure & Deployment
- **Docker & Docker Compose**: Containerized services
- **Makefile**: One‑command build and orchestration
- **NGINX + SSL**: Ready for production HTTPS deployment

---

## Security
- OAuth2 + 2FA + JWT for secure authentication
- SQL injection and XSS protection
- Production mode disables client debug logs to reduce risk
- Sanitization of all user inputs, including file uploads and form data
- Rate limiting for sensitive APIs to prevent brute-force attacks
- Protected APIs with proper access control to ensure correct authorization

---

## Quick Start
### Prerequisites
- Docker & Docker Compose
- Make
- HTTPS certificate in `/srcs/client/certificat/`
- `.env` file at root containing at least:

```env
GOOGLE_USER_ID=your-google-client-id
JWT_SECRET=your_jwt_secret_here
# Optional test accounts:
# TEST_ACCOUNTS='[{"username":"user@user.com","password":"Testuser123@","alias":"user"}]'
PRODUCTION='false'
```

### Build & Run
```bash
# Build & start all services
make

# Retrieve data
make get-data

# Put preset data before build
make put-data
```

### Access
- Local: `https://localhost`
- Remote: `https://<server-ip>`

Recommended browser: **Firefox**

---

## Deployment Notes
- Update NGINX `servername` to match domain.
- Use a trusted SSL certificate (Let’s Encrypt or commercial).
- Keep secrets (JWT, OAuth credentials) outside of repo.
- For scaling:
  - Use Redis / RabbitMQ as message broker
  - Migrate DB to PostgreSQL/MySQL for higher concurrency
  - Scale Game Engine horizontally with message queues

---

## Production‑Ready Highlights
**Backend Focus**
- Designed Node.js/Fastify microservices for real‑time WebSocket gameplay, authentication, and record storage, deployed via Docker.

**Frontend/Game Focus**
- Built a 3D multiplayer Pong game using TypeScript + Babylon.js with frame synchronization and low‑latency input handling.

**Fullstack/DevOps Focus**
- Deployed microservices with Docker & NGINX, integrated OAuth2 + 2FA authentication, and automated build with Makefile.

---

## Future Improvements
- Upgrade SQLite → PostgreSQL with migrations
- Explicit message broker (Redis/RabbitMQ) with monitoring
- Orchestration with Kubernetes/auto‑scaling
- WAF to prevent more cyber attack
- Responsive design to adapte all devices

---

## License & Contribution
MIT License. Contributions and feedback are welcome.

---

## Repository & Contact
- GitHub: https://github.com/swangarch/42transcendence

---

