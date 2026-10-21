# Island Catan Online — starter project

招待コード式・最大4人・スマホ対応のオンライン対戦プロトタイプです。

## ファイル
- `index.html` — フロントエンド一式
- `schema.sql` — Supabaseテーブル、Realtime、試作用RLSポリシー

## Supabase接続（公開前に必要）
1. Supabaseでプロジェクトを作成します。
2. Dashboard → SQL Editor で `schema.sql` の内容を実行します。
3. Project Settings → API から Project URL と anon/public key を確認します。
4. `index.html` をブラウザで開くと、初回にURLとanon keyを聞かれます。値はそのブラウザのlocalStorageに保存されます。
5. ローカルの `file://` ではブラウザ制限が出る場合があるため、ローカルHTTPサーバーか静的ホスティングで配信してください。
6. `index.html` を静的ホスティング（例：Vercel）に配置し、そのURLを友達に共有します。ホストが部屋を作り、友達は招待コードまたは `?room=XXXXXX` 付きURLから参加します。

## 重要な制限
これは動作確認用のスターターです。Supabaseのanon keyはブラウザに公開される前提ですが、`schema.sql` のRLSポリシーはプロトタイプ用に緩く、誰でもルーム状態を読んだり更新したりできます。公開利用前には、Supabase Auth、参加者の認証、サーバー側RPC/Edge Functionによる手番・資源・建設の検証、レート制限、切断時の再接続処理を実装してください。

また、ゲームロジックは簡易版です。公式ルールの完全再現ではなく、初期配置・港・取引・発展カード・CPUなど一部のルールは未実装または簡略化されています。最大4人の人間プレイヤーが参加できるオンライン同期の土台です。
