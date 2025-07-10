# ソーシャルスタディAI

中学生向けの社会科学習アプリ。AI技術を活用してパーソナライズされた学習体験を提供し、歴史・地理・公民の3分野を包括的にカバーします。

## 概要

ソーシャルスタディAIは、塾に代わる中学生向け社会科学習アプリです。Google Gemini APIを活用し、個々の学習者に最適化された問題演習と解説を提供します。

### 主な特徴

- 📚 **3分野対応**: 歴史・地理・公民を網羅
- 🤖 **AI活用**: 個別最適化された問題生成と詳細解説
- 📊 **学習分析**: 弱点の可視化と改善提案
- 🎯 **適応的学習**: 学習進度に応じた難易度調整
- 🏆 **モチベーション機能**: バッジシステムとレベルアップ機能

## 技術スタック

- **フロントエンド**: Flutter (Dart)
- **バックエンド**: Firebase
- **AI**: Google Gemini API
- **データベース**: Cloud Firestore
- **認証**: Firebase Authentication
- **ホスティング**: Firebase Hosting

## セットアップ

### 前提条件

- Flutter SDK (^3.8.0)
- Dart SDK
- Firebase CLIツール
- Google Cloud Platform アカウント

### インストール手順

1. リポジトリをクローン
```bash
git clone https://github.com/[your-username]/social_study_ai.git
cd social_study_ai
```

2. 依存関係をインストール
```bash
flutter pub get
```

3. Firebase設定ファイルを追加
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

4. 環境変数を設定（`.env`ファイルを作成）
```
GEMINI_API_KEY=your_api_key_here
```

5. アプリを実行
```bash
flutter run
```

## 開発コマンド

### アプリの実行
```bash
flutter run                    # デバッグモードで実行
flutter run --release          # リリースモードで実行
flutter run -d <device_id>     # 特定のデバイスで実行
```

### ビルド
```bash
flutter build apk              # Android APK
flutter build appbundle        # Android App Bundle
flutter build ios              # iOS（macOSのみ）
flutter build web              # Web版
```

### テスト
```bash
flutter test                   # 全テストを実行
flutter test test/widget_test.dart  # 特定のテストを実行
```

### コード品質
```bash
flutter analyze                # 静的解析
dart format .                  # コードフォーマット
```

## プロジェクト構造

```
lib/
├── main.dart                  # エントリーポイント
├── models/                    # データモデル
├── screens/                   # 画面UI
├── widgets/                   # 再利用可能なウィジェット
├── services/                  # APIとデータベースサービス
├── providers/                 # 状態管理
└── utils/                     # ユーティリティ関数
```

## 料金プラン

### 無料プラン
- 1日10問まで
- 基本的な解説
- 広告表示あり

### プレミアムプラン（月額500円）
- 無制限問題演習
- 詳細なAI解説
- 広告なし
- 高度な学習分析

## 貢献方法

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は[LICENSE](LICENSE)ファイルを参照してください。

## お問い合わせ

質問や提案がある場合は、[Issues](https://github.com/[your-username]/social_study_ai/issues)でお知らせください。