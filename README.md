# 何をするスクリプトなのか
さくらのオブジェクトストレージ上にあるバケットを
サーバにマウントするスクリプト

# どうして作ったのか
手作業でするのはちょっとめんどくさかったから

# このスクリプトを動かすときの準備/前提
- さくらのクラウドを使います。  
さくらのクラウドでサーバは作成済み。一番小さな１時間7円とかのプランでOKです。  
- OSはさくらのクラウドで用意されているアーカイブのcentOS7 です。  
インストール直後で何もしていない状態です。  
CentOS Linux release 7.3.1611 (Core)  
- オブジェクトストレージにはバケットを作成済み

# スクリプトの大まかな流れ
1. s3fsのインストール
1. マウントポイントの作成
1. マウント

# 使い方
スクリプトをダウンロードして実行する。  

```
# bash setup_objstrage.sh
```

マウントポイントは固定なので適当にスクリプトを書き換えてください。  
起動時に再マウントをする設定はしていないので、  
必要な場合は別途設定が必要です。  
