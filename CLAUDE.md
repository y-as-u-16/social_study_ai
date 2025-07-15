# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリのコードを扱う際のガイダンスを提供します。

## プロジェクト概要

ソーシャルスタディAI - 日本の中学生向けの社会科（歴史、地理、公民）学習アプリ。Google Gemini AIを活用してパーソナライズされた学習体験を提供するFlutterベースの教育アプリケーションです。

## アーキテクチャ

### ディレクトリ構造
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

## 重要な開発ガイドライン

### 1. 環境設定
- **APIキーや機密データは絶対にハードコードしない**
- ローカル開発には`.env`ファイルを使用
- `.env`が`.gitignore`に含まれていることを確認
- `flutter_dotenv`を使用して環境変数を読み込む

`.env`ファイルの例：
```
GEMINI_API_KEY=your_gemini_api_key
FIREBASE_API_KEY=your_firebase_api_key
ADMOB_APP_ID=your_admob_app_id
```

### 2. Firebaseセキュリティルール
- `firestore.rules`に適切なセキュリティルールを実装
- Firebaseエミュレータスイートを使用してルールをテスト
- ユーザーデータの分離を確保

### 3. AIコスト管理
- AI生成コンテンツをFirestoreにキャッシュ
- APIコールのレート制限を実装
- コンテンツ生成にはバッチ処理を使用
- ロギングを通じてAPI使用量を監視

### 4. データモデル

設計書からの主要なデータ構造：

**ユーザーモデル**：
- userId、name、grade（1-3）
- learningStreak、totalPoints、level
- createdAtタイムスタンプ

**学習セッション**：
- sessionId、userId
- subject（history|geography|civics）
- 正誤と所要時間を含むquestions配列
- timestamp、totalScore

**問題モデル**：
- questionId、subject、category
- difficulty（easy|medium|hard）
- 問題文、選択肢配列
- 正解インデックス、解説
- isAIGeneratedフラグ、タグ

### 5. Gitワークフロー
- 機能ブランチ：`feature/機能名`
- バグ修正：`bugfix/問題の説明`
- コミットメッセージは説明的に
- 機密データが常にgitignoreされていることを確認

### 6. テスト戦略
- すべてのサービスとユーティリティのユニットテスト
- UIコンポーネントのウィジェットテスト
- 重要なユーザーフローの統合テスト
- モックデータを使用したAIプロンプト応答のテスト

### 7. パフォーマンスの考慮事項
- `cached_network_image`で画像を遅延読み込み
- 問題リストのページネーションを実装
- リアルタイム更新にはStreamBuilderを使用
- 適切なインデックスでFirestoreクエリを最適化

### 8. 収益化の実装
- 無料プラン：1日10問まで、広告あり
- プレミアムプラン：月額500円、無制限の問題、広告なし
- iOS/Android用のアプリ内購入を実装
- 無料ユーザー向けのAdMob統合

## 開発フェーズ（設計書より）

1. **1ヶ月目**：Firebase設定、基本UI、認証、基本的な問題システム
2. **2ヶ月目**：Gemini API統合、問題生成、学習分析
3. **3ヶ月目**：パフォーマンス最適化、UI/UX改善、ストア準備

## 一般的なタスク

### 新しい画面の追加
1. `lib/screens/`配下にディレクトリを作成
2. 既存の画面構造パターンに従う
3. main.dartまたはルーター設定にルートを追加
4. 適切な状態管理を実装

### 新しいAI機能の統合
1. `lib/utils/prompts.dart`にプロンプトテンプレートを追加
2. `gemini_service.dart`にサービスメソッドを実装
3. APIコールを削減するためのキャッシュロジックを追加
4. エラーハンドリングとフォールバックを実装

### 新しい問題タイプの追加
1. 必要に応じて問題モデルを更新
2. 問題タイプ用のUIウィジェットを作成
3. 回答検証ロジックを更新
4. 問題生成プロンプトに追加

## 参照ドキュメント
- [基本設計書](/design/01_基本設計書.md)
- [テーブル設計書](/design/02_テーブル設計書.md)

# 重要な指示のリマインダー
求められたことだけを実行し、それ以上でもそれ以下でもない。
目標達成に絶対必要でない限り、ファイルを作成しない。
新しいファイルを作成するよりも、既存のファイルの編集を常に優先する。
ドキュメントファイル（*.md）やREADMEファイルを自発的に作成しない。ユーザーから明示的に要求された場合のみドキュメントファイルを作成する。