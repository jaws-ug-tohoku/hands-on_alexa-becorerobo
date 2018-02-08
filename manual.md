# 概要
お子様が組み立てたロボットをechoから操作するワークショップです。
echoには音声アシスタントのAlexaが搭載されており、「スキル」というものを自作することによって、Alexaの機能を独自に拡張することが可能です。
このワークショップでは「前進して」、「ウィンクして」、「目を光らせて」という呼びかけに対して、ロボットを動作させるようなスキルを開発してみたいと思います。

この仕組みはAlexa、Lambda、AWSIoTなどのAWSのサービスや、手のひらサイズのコンピュータRaspberryPiから構成されています。

echoに対して行った音声入力はLambdaで処理されます。

Lambdaでの処理結果はAWSIoTを中継して実機であるRaspberryPiに届き、音声入力の種類に応じて、RaspberryPiがロボットに対してBlueTooth通信を用いてどんな動作をさせるかの命令をします。




# 構成図
![全体図](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/%E5%85%A8%E4%BD%93%E5%9B%B3.png)





# ログイン
## マネジメントコンソール

AWSマネジメントコンソールへのログインを行います。
マネジメントコンソールではLambdaやAWSIoTなどAWSの各種サービスの設定等を行うことができます。

![login](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/login/1.png)

以下のURLへアクセスし、右上の「コンソールへログイン」をクリックします。

URL : https://aws.amazon.com/jp/

![login](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/login/2.png)

アカウント情報を入力し、「サインイン」をクリックします。

![login](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/login/3.png)

ログインが完了すると、画像のような画面になります。

**画面最上部右側のリージョンが「東京」になっているか確認しましょう。なっていなければ「アジアパシフィック（東京）」に変更します。**



## developerコンソール

Alexaの設定を行うために、Developerコンソール（開発者コンソール）へのログインも必要となります。
前項のマネジメントコンソールとは異ります。
そのためアカウントもAWSアカウントとは別にDeveloperアカウントというものが必要となります。


![login](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/login/4.png)

ブラウザの上部から新規でタブを開き、以下のURLへアクセスします。

URL : https://developer.amazon.com/home.html

アカウント情報を入力し、「ログイン」をクリックします。

![login](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/login/6.png)

アカウントを持っていない場合は「AmazonDeveloperアカウントを作成」をクリックします。
各項目を埋めたら「AmazonDeveloperアカウントを作成」をクリックします。
その後も項目を入力し、アカウントを作成します。

![login](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/login/5.png)

ログインが完了すると、画像のような画面になります。




# Alexaスキルの設定（前編）

**Developerコンソールから設定を行います。**

![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/1.png)

Developerコンソールを開き、「Alexa」タブをクリックします。
Alexa Skill Kitの「始める」をクリックします。


![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/2.png)

右上の「新しいスキルを追加する」をクリックします。

![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/3.png)

画像のような画面になるので、各項目を設定します。
* スキルの種類・・・カスタム対話モデル
* 言語・・・・・・・Japanese
* スキル名・・・・・「alexaday2018_workshop」
* 呼び出し名・・・・「ロボット」

を入力及び選択し、「保存する」をクリックします。
その他の項目は変更不要です。

![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/4.png)

保存されると画像のような画面になります。
新たに表示された「アプリケーションID」を控えておきます。
この値はLambdaの設定に必要です。
その後、「次へ」をクリックします。（対話モデルの設定画面に移ります）




# Lambdaの設定

**マネジメントコンソールから設定を行います。**

**画面最上部右側のリージョンが「東京」になっているか確認しましょう。**

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/login/3.png)

マネジメントコンソールを開き、「コンピューティング」から「Lambda」をクリックします。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/1.png)

「関数の作成」をクリックします。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/2.png)

作成画面に移るので、項目の設定を行います。
* 関数の作成・・・「一から作成」にチェック
* 名前・・・・・・「alexaday2018_workshop」
* ランタイム・・・Python3.6
* ロール・・・・・カスタムロールの作成

を入力及び選択します。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/3.png)

「カスタムロールの作成」を選択した時点で、新しくタブが開かれ、画像のような画面になります。
* IAMロール・・・新しいIAMロールの作成
* ロール名・・・・「alexaday2018_workshop」

を入力及び選択し、「許可」をクリックします。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/4.png)

「許可」をクリックするとタブが閉じられ、Lambda関数の作成画面に戻ります。
「ロール」が「既存のロールを選択」が選ばれた状態になっています。
* 既存のロール・・・「alexaday2018_workshop」

と、直前に作成したIAMロールを選択し、右下の「関数の作成」をクリックします。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/6.png)

完了すると、Lambdaの設定画面へと移ります。
Designer内の「トリガーの追加」から「Alexa Skill Kit」をクリックし、トリガーを追加します。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/7.png)

下にスクロールすると、「トリガーの設定」フィールドがあります。
スキルID検証・・・・・・有効（推奨）
アプリケーションID・・・Alexaの設定時に控えたアプリケーションID
を入力及び選択したら、右下の「追加」をクリックします。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/8.png)

追加されると画像のような画面になります。
Designer内のLambda関数名をクリックし、さらに設定を進めていきます。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/9.png)

下にスクロールすると、「関数コード」の設定フィールドがあります。
「lambda_function.py」に記述されているコードを全て削除し、別紙の「lambda.py」の中身を全てコピー＆ペーストします。

**コード内で以下のように記述されている箇所は、Alexaスキルの設定（前編）の最後に控えたアプリケーションIDに値を変更してください。**
```python
myAppID = ".........."
```

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/10.png)

念のためLambdaのスペックを上げておきたいので、さらに下にスクロールします。
「基本設定」フィールドで、メモリを512MB、タイムアウトを10秒に変更します。

![lambda](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/lambda/11.png)

問題がなければ一番上までスクロールし、右上の「保存」をクリックします。
保存が完了したら、保存ボタンの上にある「ARN」というテキストの「arn:aws:lambda:.....」を控えておきます。
この値はAlexaスキルの設定（後編）で必要です。




# Alexaスキルの設定（後編）

**Developerコンソールから設定を行います。**

Lambdaの設定が完了したところで、再度Alexaの設定を進めていきます。

![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/5.png)

Developerコンソールを開き、対話モデルの設定画面であることを確認します。

![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/7.png)

「インテントスキーマ」には「intentSchema.txt」の中身を全てコピー＆ペーストします。
インテントスキーマは、インテント等の情報をまとめたjson形式の設定項目です。

![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/6.png)

「サンプル発話」には「sampleSpeech.txt」の中身を全てコピー＆ペーストします。
サンプル発話は、どんな呼びかけがどのインテントと紐づいているのかを表しているものです。

その他の項目は変更不要です。

入力ができたら一番下までスクロールし、「次へ」をクリックします。

![alexa](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/alexa/8.png)

「サービスエンドポイントのタイプ」から「AWS LambdaのARN」をチェックします。

「デフォルト」という項目が現れるので、Lambdaの設定の最後で控えたARNを入力します。

その他の項目は変更不要です。

完了したら一番左下の「保存」をクリックします。





# AWSIoTの設定

**マネジメントコンソールから設定を行います。**

**画面最上部右側のリージョンが「東京」になっているか確認しましょう。**

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/1.png)

マネジメントコンソールを開き、左上の「サービス」をクリックします。
検索欄に「iot」と入力し、「AWS IoT」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/2.png)

画像のような画面になるので、左のリストから「管理」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/3.png)

IoTデバイスの登録を行うため、右上の「作成」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/4.png)

「単一のモノを作成する」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/5.png)

画像のような画面になるので、各項目の設定を行います。
名前・・・任意（ここでは「myRaspberryPi3」としました。）
その他の項目の値の変更は不要です。
名前を入力したら、一番右下の「次へ」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/6.png)

証明書の作成をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/7.png)

各種証明書や鍵のをダウンロードします。

* 「このモノの証明書」
* 「パブリックキー」
* 「プライベートキー」

の右にある「ダウンロード」をクリックし、それぞれダウンロードします。


また、「AWS IoT のルート CA」もダウンロードする必要があります。

「AWS IoT のルート CA」の右の「ダウンロード」を右クリックし、「別名でリンク先を保存」をクリックし、ファイル名を「root-CA.crt」としてダウンロードします。

その後、**「有効化」をクリック**します。

**ここでの証明書の有効化は忘れやすいポイントであるため、注意してください。**

全て満たしたら「完了」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/8.png)

完了すると、モノの一覧に追加されます。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/9.png)

左のリストから「安全性」をクリックします。
さらに下に現れる「ポリシー」をクリックします。
「ポリシー」の一覧画面が表示されます。
右上の「作成」からポリシーを追加します。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/10.png)

画像のような画面になるので、各項目を入力していきます。
* 名前・・・・・・・任意（ここでは「myRaspberryPi3-Pollicy」としました。）
* アクション・・・・「iot:*」
* リソースARN・・・「*」
* 効果・・・・・・・「許可」をチェック

問題なければ右下の「作成」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/11.png)

完了すると、一覧画面に作成したものが追加されます。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/12.png)

左のリストの「安全性」から「証明書」をクリックし、一覧から先ほど作成した証明書をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/13.png)

画面上部の右寄りに「アクション▼」という項目があるので、クリックし、「ポリシーのアタッチ」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/14.png)

画像のようなウィンドウが現れるので、先ほど作成したポリシーにチェックを入れ、「アタッチ」をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/15.png)

リストから「ポリシー」をクリックすると、作成したポリシーが紐づけられていることが確認できます。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/16.png)

リストから「モノ」をクリックし、紐づいているモノ(myRaspberryPi3)をクリックします。

![awsiot](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/17.png)

リストから「操作」をクリックすると、画像のような画面になります。
エンドポイントである「〜〜〜〜〜.iot.ap-northeast-1.amazonaws.com」を控えておきます。
この値はラズベリーパイの設定で必要になります。





# IAMの設定

**マネジメントコンソールから設定を行います。**

**画面最上部右側のリージョンが「東京」になっているか確認しましょう。**

![iam](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/19.png)

左上の「サービス」をクリックし、検索欄に「iam」と入力します。
下に表示される「IAM」をクリックします。
（「セキュリティ、アイデンティティ、コンプライアンス」以下にも「IAM」という項目をクリックしてもOKです。）

![iam](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/20.png)

左のリストから「ロール」を選択し、「alexaday2018_workshop」をクリックします。

![iam](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/21.png)

画像のような画面になるので、「ポリシーのアタッチ」をクリックします。

![iam](https://github.com/sugo-shota/hands-on_alexa-becorerobo/blob/modify/src/AWSIoT/22.png)

検索欄に「iot」と入力し絞り込みを行います。
「AWSIoTFullAccess」にチェックを入れ、右下の「ポリシーのアタッチ」をクリックします。



# ラズベリーパイの設定

## 初期設定(事前準備済み)
wifiの設定
SSH/VNC有効
piのパスワード変更
タイムゾーンの変更
staticIPの設定
=>ここまでは事前に設定済み


## sshでログイン
お手元のラズベリーパイへログインします。
ユーザー名：pi
接続先：192.168.2.xx
パスワード：alexaday2018
で接続します。

## 必要パッケージのインストール
ラズベリーパイで使用するパッケージ、pythonモジュールをインストールします。
sudo apt-get install sleepenh
git clone https://github.com/jaws-ug-tohoku/hands-on_alexa-becorerobo.git
cd hands-on_alexa-becorerobo/RaspberryPi/
sudo pip3 install -r requirements.txt

## 証明書の設置
ダウンロードした証明書や鍵を設置します。
ルート証明書
vi /home/pi/root-CA.crt

証明書
vi /home/pi/certificate.pem.crt

プライベートキー
vi /home/pi/private.pem.key

## プログラムの設置
ラズベリーパイ上でAWSIoTからMQTTデータを受信し、びーこあロボをBLEで操作するプログラムを設置します。

cd
mv /home/pi/hands-on_alexa-becorerobo/RaspberryPi/motion.bash .
mv /home/pi/hands-on_alexa-becorerobo/RaspberryPi/iot-bcore.py .

chmod 755 /home/pi/motion.bash
chmod 755 /home/pi/iot-bcore.py

cat /home/pi/motion.bash
cat /home/pi/iot-bcore.py

### ご自身のびーこあロボのMACアドレスを入力してください
sudo sh -c "echo 'BCORE_MAC=xx:xx:xx:xx:xx:xx' >> /etc/default/iot-bcore"
sudo sh -c "echo 'BCORE_MAC=88:6B:0F:27:0A:CA' >> /etc/default/iot-bcore"

### ご自身のAWS IoTの接続先を入力してください
sudo sh -c "echo 'ENDPOINT=xxxxxxxxxx.iot.ap-northeast-1.amazonaws.com' >> /etc/default/iot-bcore"
sudo sh -c "echo 'ENDPOINT=a2ajn6x7jj3xoz.iot.ap-northeast-1.amazonaws.com' >> /etc/default/iot-bcore"

## 自動起動の設定

sudo mv /home/pi/hands-on_alexa-becorerobo/RaspberryPi/alexa-robo.service /etc/systemd/system/alexa-robo.service
cat /etc/systemd/system/alexa-robo.service
----
[Unit]
Description = Auto Run Alexa-Robo
After=network.target network-online.target rsyslog.service

[Service]
Type=simple
ExecStart=/home/pi/iot.py
EnvironmentFile=/home/pi/iot-bcore

[Install]
WantedBy=network.target network-online.target rsyslog.service
-------





ネットワーク起動後にサービスを起動するようにします。

sudo raspi-config
"3 Boot Options" ->   "Wait for Network at Boot" -> " Would you like boot to wait until a network connection is established?   [YES]" -> "OK" -> Finish

プログラムを自動起動するように設定します。

sudo systemctl enable systemd-networkd
sudo systemctl enable systemd-networkd-wait-online
sudo systemctl daemon-reload
sudo systemctl start alexa-robo
sudo systemctl enable alexa-robo

sudo reboot

sudo systemctl status alexa-robo.service -l
------
● alexa-robo.service - Auto Run Alexa-Robo
   Loaded: loaded (/etc/systemd/system/alexa-robo.service; enabled)
   Active: active (running) since Wed 2018-02-07 18:01:57 JST; 3min 44s ago
:
------
=>再起動後にactive (running)となっていれば自動起動に成功しています。


# echoの設定










# 実行

**ターミナル(mac)やteratermなど(windows)から操作します。**

ラズベリーパイにSSH接続します。
コマンド : ssh pi@[IP]
パスワード : raspberry

sub_aws_iot_for_python.pyを置いたフォルダに移動し、以下のコマンドでファイルを実行します。
コマンド : python3 sub_aws_iot_for_python.py

echoに「アレクサ、ロボットで◯◯して」と呼びかけます。
「◯◯」には「sampleSpeech.txt」の日本語部分が入ります。

例1）アレクサ、ロボットで前進して。
例2）アレクサ、ロボットでウィンクして。
例3）アレクサ、ロボットで目を光らせて。

命令によってロボットが動けば成功です。


# bcoreモジュールの操作について
http://vagabondworks.jp/blog-entry-125.html