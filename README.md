# README

## 開発環境
* Ruby version  
2.6.0

* System dependencies  
slack-notifier  

## bitcoindの準備
  * ビットコインブロックチェーンデータを永続化する任意のディレクトリを作成  
    ```bash
      mkdir ~/Program/bitcoind-data  
    ```

  * コンテナ間通信をするためにローカルネットワーク作成
    ```bash
    docker network create bitcoind
    ```

  * nodeを立ち上げるためのimageを取得  
    ``` bash
      docker pull kylemanna/bitcoind:latest  
    ```

  * diff_bitcoin_node_and_explorer_block/bitcoindに移動  
    ``` bash
      cd ~/Program/diff_bitcoin_node_and_explorer_block/bitcoind  
    ```

  * bitcoinnodeを起動  
    ``` bash
    docker run -v ~/Program/bitcoind-data:/bitcoin/.bitcoin --name=bitcoind-node -d \
        --network bitcoind \
        -p 8333:8333 \
        -p 127.0.0.1:8332:8332 \
        -v $PWD/bitcoin.conf:/bitcoin/.bitcoin/bitcoin.conf \
        kylemanna/bitcoind:latest  
    ```

  * dataが読み込まれているか確認  
    ``` bash
      docker logs -f bitcoind-node
    ```

  * コンテナの中に入る  
    ``` bash
      docker exec -it bitcoind-node bash -l  
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
  # Dockerfileまで移動
  cd ~/Program/diff_bitcoin_node_and_explorer_block
  # バッチイメージの作成
  docker build -t coincheck_test_batch_image .
  # バッチの起動 crontabの間隔でバッチが流れる
  docker run --rm --network bitcoind --name coincheck_test_batch_container coincheck_test_batch_image:latest
  ```

* バッチを止める
  ```
  docker stop coincheck_test_batch_container
  ```

* バッチの修正
  ``` bash
  # imageの削除
  docker rmi coincheck_test_batch_image:latest
  # バッチの中身を修正修正
  # バッチを起動するの手順で起動
  ```