# Berkel Tracker - Fault Tracking Service v2.1

A comprehensive fault tracking and management system built with Flutter and Firebase, designed for managing technical issues across various locations including metro stations, government offices, airports, and other public facilities.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [User Roles & Permissions](#user-roles--permissions)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Database Structure](#database-structure)
- [Key Features](#key-features)
- [Platform Support](#platform-support)
- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Documentation](#documentation)

## 🎯 Overview

Berkel Tracker is a cross-platform fault tracking system that enables organizations to efficiently manage technical issues, assign tasks to technicians, track progress, and generate comprehensive reports. The system supports multiple user roles with role-based access control and provides real-time updates across all connected devices.

**Version:** 2.1  
**Last Updated:** December 2024  
**Project Type:** Flutter + Firebase Fault Tracking System

## ✨ Features

### Core Functionality
- ✅ **Multi-role User Management** - Admin, Call Center, and Technician roles with granular permissions
- ✅ **Comprehensive Fault Reporting** - Report faults with location, category, and detailed notes
- ✅ **Real-time Task Assignment** - Assign tasks to technicians with priority ordering
- ✅ **Advanced Search & Filtering** - Search by location, category, date range, and more
- ✅ **Excel Export** - Export reports to Excel format (.xlsx)
- ✅ **WhatsApp Integration** - Share task lists and reports via WhatsApp
- ✅ **Role-based Navigation** - Dynamic navigation based on user permissions
- ✅ **Multi-platform Support** - Web, Mobile (Android/iOS), and Desktop (Windows/macOS/Linux)
- ✅ **Real-time Updates** - Firebase Firestore streams for live data synchronization
- ✅ **Modern UI** - Material Design 3 with responsive layouts

### Fotobooth Management System
- ✅ **Complete CRUD Operations** - Create, read, update, and delete fotobooth locations
- ✅ **Bulk Operations** - Upload/delete multiple fotobooths at once
- ✅ **Advanced Search** - Real-time search by name, category, or ID
- ✅ **Category Filtering** - Filter by metro lines, government offices, etc.
- ✅ **Data Import** - Upload station data from dataset
- ✅ **Statistics Dashboard** - View total, filtered, and selected counts

## 🏗️ Architecture

- **Frontend:** Flutter (Cross-platform framework)
- **Backend:** Firebase (Firestore, Authentication)
- **State Management:** StatefulWidget with Streams
- **Authentication:** Firebase Auth with custom role-based access control
- **Database:** Cloud Firestore (NoSQL document database)

## 👥 User Roles & Permissions

### 1. ADMIN
- Full system access
- User management (create, update, delete users)
- Settings management
- All reporting features
- Problem type configuration
- Tool counter management
- Fotobooth management
- Access to all screens via drawer navigation

### 2. CALL CENTER
- Fault reporting
- Task assignment
- User task management
- Reporting features
- Limited settings access
- Access to multiple screens via bottom navigation

### 3. TECHNICIAN
- View assigned tasks
- Update task status
- Personal task management
- Basic fault reporting
- Limited screen access (personal tasks and fault reporting)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7.0 or higher
- Dart SDK 3.7.0 or higher
- Firebase account and project
- Android Studio / VS Code (recommended)
- Firebase CLI (for deployment)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd berkel_tracking_serviseV2.1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add your platform configurations (Web, Android, iOS)
   - Update `lib/firebase_services/firebase_options.dart` with your Firebase configuration

4. **Deploy Firestore Rules**
   ```bash
   firebase deploy --only firestore:rules
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

### Firebase Configuration

Update `firebase.json` and `firestore.rules` according to your Firebase project settings. Configure your Firebase project ID and web config in `lib/firebase_services/firebase_options.dart`.

## 📁 Project Structure

```
lib/
├── constants/              # Constants and datasets
│   ├── dataset.dart       # Station data
│   └── metroline.dart     # Metro line definitions
├── firebase_services/     # Firebase integration
│   ├── auth_service.dart
│   ├── firestoreservies.dart
│   ├── app_settings_service.dart
│   ├── fotobooth_service.dart
│   └── firebase_options.dart
├── models/                 # Data models
│   ├── fault_model.dart
│   ├── fotobooths_model.dart
│   ├── user_management_model.dart
│   ├── user_plan.dart
│   └── ...
├── screens/                # Application screens
│   ├── auth_screens/      # Login/Signup
│   ├── report_screens/    # Reporting interfaces
│   ├── settings_screens/  # Settings and admin
│   ├── main_app_screen.dart
│   ├── faultscreen.dart
│   ├── planscreen.dart
│   └── ...
├── services/               # Business logic services
│   └── navigation_service.dart
├── utils/                  # Utility functions
│   └── ...
├── widgets/                # Reusable UI components
│   ├── fotobooth_widgets/
│   └── ...
└── main.dart               # Application entry point
```

## 🗄️ Database Structure

### Firestore Collections

#### 1. `userplans` - Main Fault/Task Collection
```json
{
  "boothId": "string",
  "stationName": "string",
  "category": "string",
  "problem": "string",
  "finderName": "string",
  "finderNote": "string",
  "gonerName": "string",
  "gonerNote": "string",
  "timestamp": "timestamp",
  "problemFixedTime": "timestamp",
  "isAssigned": "boolean",
  "isDone": "boolean",
  "saveFault": "boolean",
  "orderForPlan": "number",
  "orderForUser": "number"
}
```

#### 2. `app_settings/user_management/users` - User Accounts
```json
{
  "userName": "string",
  "password": "string",
  "role": "string",
  "createdAt": "timestamp",
  "lastUpdated": "timestamp"
}
```

#### 3. `app_settings/problem_settings/problems` - Problem Types
```json
{
  "problemName": "string",
  "category": "string",
  "note": "string",
  "createdAt": "timestamp",
  "lastUpdated": "timestamp"
}
```

#### 4. `app_settings/tool_counter/tools` - Tool Inventory
```json
{
  "toolName": "string",
  "count": "number",
  "transactions": "array",
  "createdAt": "timestamp",
  "lastUpdated": "timestamp"
}
```

#### 5. `fotobooths` - Fotobooth Locations
```json
{
  "fotoboothId": "number",
  "category": "string",
  "name": "string",
  "createdAt": "timestamp",
  "lastUpdated": "timestamp"
}
```

## 🎯 Key Features

### Fault Reporting System
- Multi-category fault reporting
- Location-based categorization
- Real-time fault tracking
- Photo and note attachments
- Status management (pending, in-progress, completed)

### Task Management
- Task assignment to technicians
- Priority-based task ordering
- Task status tracking
- Personal task dashboards
- Task filtering and search

### Reporting & Analytics
- Comprehensive fault reports
- Excel export functionality
- Date range filtering
- Category-based reporting
- Performance analytics
- WhatsApp sharing integration

### Search & Filtering
- Advanced search functionality
- Multi-criteria filtering
- Real-time search results
- Location-based filtering
- Category filtering

### Fotobooth Management
- Complete CRUD operations
- Bulk upload/delete
- Real-time updates
- Category-based organization
- Statistics dashboard

## 📱 Platform Support

### Mobile Platforms
- **Android:** API 21+ (Android 5.0+)
- **iOS:** 12.0+

### Desktop Platforms
- **Windows:** 10.0.19041+
- **macOS:** 10.14+
- **Linux:** Ubuntu 18.04+

### Web Platform
- Modern browsers (Chrome, Firefox, Safari, Edge)
- PWA support
- Service worker integration
- Responsive design

## ⚙️ Configuration

### Firebase Setup
1. Create a Firebase project
2. Enable Firestore Database
3. Enable Firebase Authentication
4. Configure platform-specific settings
5. Deploy security rules

### Environment Variables
Update `lib/firebase_services/firebase_options.dart` with your Firebase configuration.

### Security Rules
Deploy Firestore security rules from `firestore.rules`:
```bash
firebase deploy --only firestore:rules
```

## 📦 Dependencies

### Core Dependencies
- `flutter` - Flutter SDK
- `cloud_firestore: ^5.6.7` - Firestore database
- `firebase_core: ^3.13.0` - Firebase core
- `firebase_auth: ^5.5.3` - Authentication

### Utility Dependencies
- `intl: ^0.20.2` - Internationalization
- `excel: ^2.0.7` - Excel export
- `path_provider: ^2.0.8` - File system access
- `share_plus: ^6.0.0` - Sharing functionality
- `url_launcher: ^6.1.7` - URL handling

### Development Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Code analysis

## 📚 Documentation

### Additional Documentation Files
- `BERKEL_TRACKER_DOCUMENTATION.txt` - Complete system documentation
- `FOTOBOOTH_MANAGEMENT_README.md` - Fotobooth management system guide
- `FOTOBOOTH_UPLOAD_README.md` - Fotobooth data upload guide
- `overall.txt` - Project overview

### Supported Location Categories

The system supports various location categories including:
- Metro lines and stations
- Government facilities
- Public service offices
- Commercial locations
- Other facility types

Location data is managed through the Fotobooth Management System and can be customized based on your requirements.

### Fault Types
- Kamera (Camera)
- Bilgisayar (Computer)
- Ekran (Screen)
- Para makinesi (Cash Machine)
- Led (LED)
- Plexi (Plexiglass)
- Yazıcı (Printer)
- Kontrol (Control System)
- Trafo (Transformer)
- Citizen Kağıt (Citizen Paper)
- RX1 Kağıt (RX1 Paper)
- Kamera camı (Camera Glass)
- Tahsilat (Collection)
- Kredi kart cihaz (Credit Card Device)
- Perde (Curtain)

## 🔒 Security

- Firebase security rules for authenticated access
- Role-based access control
- Secure authentication with Firebase Auth
- Data validation and sanitization
- Document-level security

## 🛠️ Development

### Running the App
```bash
# Development mode
flutter run

# Release mode
flutter run --release

# Web
flutter run -d chrome

# Specific device
flutter run -d <device-id>
```

### Building
```bash
# Android APK
flutter build apk

# iOS
flutter build ios

# Web
flutter build web

# Windows
flutter build windows
```

## 📝 License

This project is proprietary software. All rights reserved.

## 👥 Support

For issues, questions, or contributions, please contact the development team.

---

**Berkel Tracker v2.1** - Comprehensive Fault Tracking and Management System
