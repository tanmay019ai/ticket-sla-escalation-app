# 🚀 Ticket SLA Escalation App

<div align="center">

<!-- TODO: Add project logo if available in repository -->

[![GitHub stars](https://img.shields.io/github/stars/tanmay019ai/ticket-sla-escalation-app?style=for-the-badge)](https://github.com/tanmay019ai/ticket-sla-escalation-app/stargazers)

[![GitHub forks](https://img.shields.io/github/forks/tanmay019ai/ticket-sla-escalation-app?style=for-the-badge)](https://github.com/tanmay019ai/ticket-sla-escalation-app/network)

[![GitHub issues](https://img.shields.io/github/issues/tanmay019ai/ticket-sla-escalation-app?style=for-the-badge)](https://github.com/tanmay019ai/ticket-sla-escalation-app/issues)

[![GitHub license](https://img.shields.io/github/license/tanmay019ai/ticket-sla-escalation-app?style=for-the-badge)](LICENSE) <!-- TODO: Add actual license file and name -->

**A comprehensive mobile application for managing support tickets with automated SLA escalation, powered by React Native (Expo) and a Node.js Express API.**

</div>

## 📖 Overview

The Ticket SLA Escalation App is designed to streamline ticket management and ensure timely resolution by automating Service Level Agreement (SLA) tracking and escalation. It provides a robust backend API for managing tickets and users, coupled with a user-friendly mobile interface for agents and administrators to interact with the system on the go. This application addresses the critical need for efficient support operations by proactively escalating tickets that breach their defined SLAs, thereby preventing delays and improving customer satisfaction.

## ✨ Features

-   🎯 **Secure User Authentication**: Robust user registration and login system with JSON Web Token (JWT) based authentication.
-   🎫 **Comprehensive Ticket Management**: Create, view, update, and manage support tickets with various statuses and priorities.
-   ⏰ **SLA Tracking**: Assign and monitor Service Level Agreements for each ticket.
-   🚨 **Automated Ticket Escalation**: Tickets are automatically escalated based on predefined SLA rules using a scheduled cron job.
-   📱 **Cross-Platform Mobile App**: Native-like experience on both Android and iOS devices, built with React Native and Expo.
-   💾 **Persistent Data Storage**: Utilizes MongoDB for flexible and scalable data management.
-   🛡️ **Role-Based Access Control**: (Inferred) Distinguish between different user roles (e.g., agents, administrators).

## 🖥️ Screenshots
![Backend Flow](images/backend_flow.png)

## 🛠️ Tech Stack

**Mobile Frontend:**

[![React Native](https://img.shields.io/badge/React_Native-61DAFB?style=for-the-badge&logo=react&logoColor=white)](https://reactnative.dev/)

[![Expo](https://img.shields.io/badge/Expo-1B1F23?style=for-the-badge&logo=expo&logoColor=white)](https://expo.dev/)
<!-- Inferred: -->

[![React Navigation](https://img.shields.io/badge/React_Navigation-lightseagreen?style=for-the-badge&logo=reactnavigation&logoColor=white)](https://reactnavigation.org/)

[![Axios](https://img.shields.io/badge/axios-6725F5?style=for-the-badge&logo=axios&logoColor=white)](https://axios-http.com/)

**Backend API:**

[![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org/)

[![Express.js](https://img.shields.io/badge/Express.js-000000?style=for-the-badge&logo=express&logoColor=white)](https://expressjs.com/)
<!-- Inferred: -->

[![Mongoose](https://img.shields.io/badge/Mongoose-800000?style=for-the-badge&logo=mongoose&logoColor=white)](https://mongoosejs.com/)

[![JSON Web Tokens](https://img.shields.io/badge/JWT-000000?style=for-the-badge&logo=json-web-tokens&logoColor=white)](https://jwt.io/)

[![Bcrypt](https://img.shields.io/badge/Bcrypt-red?style=for-the-badge)](https://www.npmjs.com/package/bcrypt)

[![Node-cron](https://img.shields.io/badge/node--cron-purple?style=for-the-badge)](https://www.npmjs.com/package/node-cron)

**Database:**

[![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)](https://www.mongodb.com/)

## 🚀 Quick Start

Follow these steps to get the Ticket SLA Escalation App up and running on your local machine.

### Prerequisites

Before you begin, ensure you have the following installed:

-   **Node.js**: `v14.x` or higher (recommended `v18.x` or `v20.x`)
-   **npm** or **Yarn**: Node.js package manager
-   **Expo CLI**: For developing and running the mobile app
    ```bash
    npm install -g expo-cli
    ```
-   **MongoDB Atlas Account**: A free tier account is sufficient to host your database.

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/tanmay019ai/ticket-sla-escalation-app.git
    cd ticket-sla-escalation-app
    ```

2.  **Install Backend Dependencies**
    Navigate into the `backend` directory and install its dependencies:
    ```bash
    cd backend
    npm install
    # or yarn install
    ```

3.  **Install Mobile App Dependencies**
    Navigate into the `mobile` directory and install its dependencies:
    ```bash
    cd ../mobile
    npm install
    # or yarn install
    ```

### Environment Setup

Create `.env` files for both the backend and mobile app to configure environment variables.

1.  **Backend Environment Variables (`backend/.env`)**
    Create a file named `.env` in the `backend` directory and add the following:
    ```
    PORT=5000
    MONGO_URI=your_mongodb_atlas_connection_string
    JWT_SECRET=a_strong_secret_key_for_jwt
    CRON_SCHEDULE="0 */1 * * *" # Example: run every hour
    ```
    *   `MONGO_URI`: Replace with your MongoDB Atlas connection string (e.g., `mongodb+srv://user:pass@cluster.mongodb.net/dbname?retryWrites=true&w=majority`).
    *   `JWT_SECRET`: A unique, strong secret string for signing JWTs.
    *   `CRON_SCHEDULE`: A cron expression for the escalation scheduler (e.g., `0 */1 * * *` means "At minute 0 past every hour.").

2.  **Mobile App Environment Variables (`mobile/.env`)**
    Create a file named `.env` in the `mobile` directory and add the following:
    ```
    API_URL=http://localhost:5000/api # Or your deployed backend URL
    ```
    *   `API_URL`: Set this to the URL where your backend API is running. If running locally, use `http://<your-machine-ip>:5000/api` to access from your mobile device, or `http://localhost:5000/api` for web/emulator testing.

### Start Development Servers

1.  **Start the Backend API**
    Navigate back to the `backend` directory and start the server:
    ```bash
    cd backend
    npm run dev # or `npm start` if `dev` script is not defined, assuming nodemon for development
    ```
    The backend API should now be running on `http://localhost:5000`.

2.  **Start the Mobile App**
    Navigate to the `mobile` directory and start the Expo development server:
    ```bash
    cd ../mobile
    expo start
    ```
    This will open a new tab in your browser with the Expo DevTools.

3.  **Open Your Mobile App**
    *   **Android/iOS physical device**: Scan the QR code displayed in the terminal or Expo DevTools using the [Expo Go app](https://expo.dev/client).
    *   **Android Emulator**: Press `a` in the terminal or click "Run on Android device/emulator" in Expo DevTools.
    *   **iOS Simulator**: Press `i` in the terminal or click "Run on iOS simulator" in Expo DevTools (requires macOS and Xcode).

## 📁 Project Structure

The project follows a monorepo-like structure, separating the backend API and the mobile frontend into distinct directories.

```
ticket-sla-escalation-app/
├── backend/                  # Node.js Express API
│   ├── config/               # Database connection, environment setup
│   ├── controllers/          # Business logic for API endpoints
│   ├── models/               # Mongoose schemas for data models (e.g., User, Ticket)
│   ├── routes/               # API routes definitions
│   ├── middleware/           # Authentication middleware (e.g., JWT verification)
│   ├── utils/                # Utility functions (e.g., error handling, cron jobs)
│   ├── .env.example          # Example environment variables
│   ├── .env                  # Local environment variables
│   ├── package.json          # Backend dependencies and scripts
│   └── server.js             # Main entry point for the Express app
├── mobile/                   # React Native (Expo) Mobile Application
│   ├── assets/               # Static assets (images, fonts)
│   ├── components/           # Reusable UI components
│   ├── context/              # React Context for global state (e.g., AuthContext)
│   ├── navigation/           # React Navigation setup
│   ├── screens/              # Individual application screens/pages
│   ├── services/             # API interaction logic (e.g., Axios instance)
│   ├── utils/                # Utility functions
│   ├── .env.example          # Example environment variables
│   ├── .env                  # Local environment variables
│   ├── App.js                # Main entry point for the React Native app
│   ├── app.json              # Expo configuration file
│   └── package.json          # Mobile app dependencies and scripts
├── README.md                 # Project README file
├── .gitignore                # Git ignore rules
└── LICENSE                   # Project license file (TODO: Create this file)
```

## ⚙️ Configuration

### Environment Variables

Both the backend and mobile app use `.env` files for configuration. Refer to the "Environment Setup" section above for details on required variables.

### Backend Configuration Files

-   **`backend/config/db.js` (inferred):** Handles MongoDB connection.
-   **`backend/utils/cron.js` (inferred):** Contains the `node-cron` setup for SLA escalation.

### Mobile App Configuration Files

-   **`mobile/app.json`:** Expo-specific configuration including app name, icon, splash screen, and platform settings.
-   **`mobile/src/navigation/index.js` (inferred):** Defines the navigation flow of the application.

## 🔧 Development

### Available Scripts

#### Backend (`backend/package.json`)

| Command       | Description                                                 |

| :------------ | :---------------------------------------------------------- |

| `npm start`   | Starts the backend API server.                              |

| `npm run dev` | Starts the backend API server with `nodemon` for auto-restarts during development. |

#### Mobile (`mobile/package.json`)

| Command       | Description                                                 |

| :------------ | :---------------------------------------------------------- |

| `expo start`  | Starts the Expo development server and Metro bundler.       |

| `expo start --no-dev --minify` | Starts the development server in production mode. |

| `expo prebuild` | Generates native project files (iOS, Android) based on `app.json`. |

| `expo run:android` | Builds and runs the Android app on a device/emulator (requires native environment setup). |

| `expo run:ios` | Builds and runs the iOS app on a simulator (requires macOS, Xcode, and native environment setup). |

| `npm test`    | (If Jest/testing framework is set up) Runs unit/integration tests. |

## 🧪 Testing

Testing for the **mobile app** is typically performed using:
-   **Android Emulator**: Provided by Android Studio.
-   **iOS Simulator**: Provided by Xcode (macOS only).
-   **Physical Devices**: Using the Expo Go app or by building standalone apps.

For the **backend**, while no explicit testing framework was detected, it's recommended to implement unit and integration tests using frameworks like Jest or Mocha.

## 🚀 Deployment

### Backend Deployment

To deploy the Node.js Express backend:

1.  **Build (if transpilation is used):**
    ```bash
    cd backend
    # If using Babel/TypeScript: npm run build
    ```
2.  **Environment Variables:** Ensure all production environment variables (e.g., `MONGO_URI`, `JWT_SECRET`, `PORT`) are correctly configured in your hosting environment.
3.  **Hosting:** Deploy to a cloud platform such as Heroku, Vercel (for serverless functions), AWS EC2, DigitalOcean, or render.com.

### Mobile App Deployment

To deploy the React Native Expo mobile app:

1.  **Production Build**
    ```bash
    cd mobile
    eas build --platform android # For Android app bundle (.aab) or APK
    eas build --platform ios    # For iOS app (.ipa)
    ```
    This requires an [EAS account](https://expo.dev/eas). You can also build locally using `expo build:[android/ios]` (deprecated for standalone apps, consider `eas build`).

2.  **Release to Stores:** Once built, you can submit the generated `.aab` or `.ipa` files to the Google Play Store and Apple App Store, respectively.

## 📚 API Reference

The backend API exposes various endpoints for managing users and tickets. All API endpoints are prefixed with `/api`.

### Authentication

-   **`POST /api/auth/register`**: Register a new user.
-   **`POST /api/auth/login`**: Authenticate a user and receive a JWT.
-   **Middleware**: Most endpoints require a valid JWT in the `Authorization` header (`Bearer <token>`).

### User Management (Inferred)

-   **`GET /api/users/me`**: Get current user's profile.
-   **`PUT /api/users/me`**: Update current user's profile.

### Ticket Management

-   **`POST /api/tickets`**: Create a new support ticket.
-   **`GET /api/tickets`**: Retrieve all tickets (with filtering/pagination, if implemented).
-   **`GET /api/tickets/:id`**: Retrieve a single ticket by ID.
-   **`PUT /api/tickets/:id`**: Update an existing ticket.
-   **`DELETE /api/tickets/:id`**: Delete a ticket.

## 🤝 Contributing

We welcome contributions to improve this project! Please see our [Contributing Guide](CONTRIBUTING.md) for details on how to get started. <!-- TODO: Create CONTRIBUTING.md -->

### Development Setup for Contributors

The development setup is straightforward as described in the [Quick Start](#🚀-quick-start) section. Ensure you follow the environment setup for both the `backend` and `mobile` components.

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the [LICENSE](LICENSE) file for details. <!-- TODO: Create LICENSE file if not present, and confirm license type. -->

## 🙏 Acknowledgments

-   **Node.js & Express.js**: For the robust backend API.
-   **React Native & Expo**: For enabling rapid cross-platform mobile development.
-   **MongoDB**: For scalable and flexible data storage.
-   **JSON Web Tokens**: For secure authentication.
-   **node-cron**: For scheduling automated ticket escalation.
-   The wider open-source community for countless libraries and tools.
