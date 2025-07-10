# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ソーシャルスタディAI - A Flutter-based educational app for Japanese middle school students studying social studies (history, geography, civics). The app uses Google Gemini AI for personalized learning experiences.

## Development Commands

### Running the Application
```bash
# Run on connected device or emulator
flutter run

# Run on specific device
flutter run -d <device_id>

# List available devices
flutter devices

# Run in release mode
flutter run --release

# Run with hot reload disabled
flutter run --no-hot
```

### Building the Application
```bash
# Android
flutter build apk
flutter build appbundle

# iOS (macOS only)
flutter build ios

# Web
flutter build web

# Desktop
flutter build macos
flutter build windows
flutter build linux
```

### Code Quality & Testing
```bash
# Run tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage

# Analyze code
flutter analyze

# Format code
dart format .

# Check formatting without applying
dart format --set-exit-if-changed .
```

### Dependency Management
```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Add a dependency
flutter pub add <package_name>

# Add dev dependency
flutter pub add --dev <package_name>
```

### Firebase Commands
```bash
# Deploy Firebase functions
firebase deploy --only functions

# Deploy Firestore rules
firebase deploy --only firestore:rules

# Deploy to hosting
firebase deploy --only hosting

# Emulator suite
firebase emulators:start
```

## Architecture

### Directory Structure
```
lib/
├── main.dart                  # アプリのエントリーポイント
├── models/                    # データモデル
│   ├── user.dart             # ユーザーモデル
│   ├── question.dart         # 問題モデル
│   └── learning_session.dart # 学習セッションモデル
├── screens/                   # 画面UI
│   ├── dashboard/            # ダッシュボード画面
│   ├── learning/             # 学習画面
│   ├── analysis/             # 分析画面
│   └── settings/             # 設定画面
├── widgets/                   # 再利用可能なウィジェット
├── services/                  # APIとデータベースサービス
│   ├── firebase_service.dart # Firebase関連
│   ├── gemini_service.dart   # Gemini AI API
│   └── auth_service.dart     # 認証サービス
├── providers/                 # 状態管理（Provider/Riverpod）
└── utils/                     # ユーティリティ関数
```

### Key Dependencies (from design document)
```yaml
dependencies:
  flutter: ^3.0.0
  firebase_core: ^2.0.0
  cloud_firestore: ^4.0.0
  firebase_auth: ^4.0.0
  google_generative_ai: ^0.2.0
  fl_chart: ^0.60.0
  cached_network_image: ^3.2.0
  flutter_dotenv: # For environment variables
  google_mobile_ads: # For AdMob integration
```

## Important Development Guidelines

### 1. Environment Configuration
- **Never hardcode API keys or sensitive data**
- Use `.env` file for local development
- Ensure `.env` is in `.gitignore`
- Load environment variables using `flutter_dotenv`

Example `.env` file:
```
GEMINI_API_KEY=your_gemini_api_key
FIREBASE_API_KEY=your_firebase_api_key
ADMOB_APP_ID=your_admob_app_id
```

### 2. Firebase Security Rules
- Implement proper security rules in `firestore.rules`
- Test rules using Firebase emulator suite
- Ensure user data isolation

### 3. AI Cost Management
- Cache AI-generated content in Firestore
- Implement rate limiting for API calls
- Use batch processing for content generation
- Monitor API usage through logging

### 4. Data Models

Key data structures from design document:

**User Model**:
- userId, name, grade (1-3)
- learningStreak, totalPoints, level
- createdAt timestamp

**Learning Session**:
- sessionId, userId
- subject (history|geography|civics)
- questions array with correctness and time spent
- timestamp, totalScore

**Question Model**:
- questionId, subject, category
- difficulty (easy|medium|hard)
- question text, options array
- correctAnswer index, explanation
- isAIGenerated flag, tags

### 5. Git Workflow
- Feature branches: `feature/functionality-name`
- Bug fixes: `bugfix/issue-description`
- Commit messages should be descriptive
- Always ensure sensitive data is gitignored

### 6. Testing Strategy
- Unit tests for all services and utilities
- Widget tests for UI components
- Integration tests for critical user flows
- Test AI prompt responses with mock data

### 7. Performance Considerations
- Lazy load images with `cached_network_image`
- Implement pagination for question lists
- Use StreamBuilder for real-time updates
- Optimize Firestore queries with proper indexing

### 8. Monetization Implementation
- Free tier: 10 questions/day with ads
- Premium tier: ¥500/month, unlimited questions, no ads
- Implement in-app purchases for iOS/Android
- AdMob integration for free users

## Development Phases (from design document)

1. **Month 1**: Firebase setup, basic UI, auth, basic question system
2. **Month 2**: Gemini API integration, question generation, learning analytics
3. **Month 3**: Performance optimization, UI/UX improvements, store preparation

## Common Tasks

### Adding a new screen
1. Create directory under `lib/screens/`
2. Follow existing screen structure pattern
3. Add route in main.dart or router configuration
4. Implement proper state management

### Integrating new AI feature
1. Add prompt template in `lib/utils/prompts.dart`
2. Implement service method in `gemini_service.dart`
3. Add caching logic to reduce API calls
4. Implement error handling and fallbacks

### Adding new question type
1. Update question model if needed
2. Create UI widget for the question type
3. Update answer validation logic
4. Add to question generation prompts

## Debugging Tips

- Use Flutter DevTools for performance profiling
- Check Firebase console for Firestore usage
- Monitor Gemini API dashboard for usage/costs
- Use `flutter logs` for device logging