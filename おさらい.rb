# cd projects
# rails _6.0.0_ new mini_talk_app -d mysql
# cd mini_talk_app
# rails db:create

# rails g controller messages new
# rails g model message text:text # モデルの作成時にmessagesテーブルにtext型でtextカラムを追加
# rails db:migrate

# app/config/routes.rb  # ルーティングの設定

# app/controllers/messages_controller.rb  # アクション設定

# app/views/messages/new.html.erb  # メッセージの一覧とフォームを表示

# rails s で、ローカル状態確認。

# ----------
# 「Action Cableの実装」
# Action Cableは、通常のRailsのアプリケーションと同様の記述で、即時更新機能を実装できるフレームワーク

# Channel(チャネル)の作成
# チャネルとは、即時更新機能を実現するサーバー側の仕組み
# ----------

# ①ターミナル rails g channel message
# ※app/channels/message_channel.rbとapp/javascript/channels/message_channel.jsが重要なファイル

# message_channel.rbは、クライアントとサーバーを結びつけるためのファイル
# message_channel.jsは、サーバーから送られてきたデータをクライアントの画面に描画するためのファイル

# ②app/channel/message_channel.rb
# stream_fromの追加

# ③messages_controller.rbにbroadcastを記述

# ④app/javascript/channels/message_channel.js
# message_channel.jsを編集

# rails s でローカル状態を確認。
# 入力コメントが反映されていればOK

# ----------

# ActionCableを用いて実装したアプリケーションを、本番環境で使用するための設定をおこなう。分けると、
# 1 HerokuでもAWSでも必要な設定
# 2 Herokuを用いてデプロイする場合にのみ必要な設定
# 3 AWSを用いてデプロイする場合にのみ必要な設定
# となる。

# 1 → config/cable.yml ファイルの編集（アダプタの指定）
# 2 → config/environment/production.rb ファイルの編集
# Herokuへデプロイする場合には、commit と pushを行い、git push heroku masterコマンドにてデプロイを行う。
# 「FURIMAへの追加実装ではなく、ミニアプリをデプロイされる場合は、"予めローカルリポジトリが作成されていることが条件"となる。」

# ----------

# Heroku上にアプリケーションを作成
# heroku create herokuのアプリ名-数字

# 設定できたことを確認
# git config --list | grep heroku

# Heroku上でMySQLを使えるようにする
# Herokuでは、使用するデータベースの設定が、デフォルトでPostgreSQLというデータベースになっている。
# ClearDBというデータベースサービスが提供しているアドオンで、これを追加することにより、HerokuでMySQLを使用できるようになる。
# heroku addons:add cleardb

# ClearDBデータベースのURLを変数heroku_cleardbに格納する。
# heroku_cleardb=`heroku config:get CLEARDB_DATABASE_URL`

# データベースのURLを再設定する。
# デフォルトでmysql2というGemを使用しているので、DATABASE_URLの冒頭がmysql2://に変更されていることも確認する。
# heroku config:set DATABASE_URL=mysql2${heroku_cleardb:5}

# Heroku上にマスターキーを設置する
# heroku config:set RAILS_MASTER_KEY=`cat config/master.key`

# heroku config
# マスターキーが設定されているか確認

# herokuで使用するサービスのバージョン指定を行う
# heroku stack:set heroku-18 -a herokuのアプリ名-数字

# herokuへアプリを追加
# git push heroku master

# herokuへデータ反映
# heroku run rails db:migrate

# 情報確認
# heroku apps:info