# README

## 開発環境
* Ruby version  
2.6.0

* System dependencies  
slack-notifier  

## bitcoindの準備
  * bitcoindのimageを取得
  ``` bash
  docker build -t bitcoind_image .
  ```

  * bitcoindの起動
  ``` bash
  docker run --name bitcoind bitcoind_image:latest
  ```

## バッチの実行
* Dockerfile内のslackのURLを通知を送りたいWebhookのURLに変更する  
  ``` bash
  ENV SLACK_WEBHOOK_URL "https://hooks.slack.com/services/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"  
  ```

* バッチの実行時間を設定  
  crontabファイル修正し実行したい時間の間隔に設定する  

* バッチを起動する  
  ``` bash
  # バッチイメージの作成
  docker build -t coincheck_test_batch_image .
  # バッチの起動 crontabの間隔でバッチが流れる
  docker run --rm --name coincheck_test_batch_container coincheck_test_batch_image:latest
  ```

* バッチを止める
  ```
  docker stop coincheck_test_batch_container
  ```

* バッチの修正
  ``` bash
  # imageの削除
  docker rmi coincheck_test_batch_image:latest
  # 修正後にバッチを起動するの手順で起動
  ```