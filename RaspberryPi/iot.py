#!/usr/bin/python3
# coding: UTF-8

from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import time
import os

# Custom MQTT message callback
#1秒ごとにsubし続けているときにトピックからなにかしら受け取ったら呼ばれる関数
def customCallback(client, userdata, message):
    topic = str(message.topic)
    print(topic)
    if(topic == "robot/walk"):
        walkIntent()
    elif(topic == "robot/wink"):
        winkIntent()
    elif(topic == "robot/light"):
        lightIntent()
    else:
        print("none")

def walkIntent():
    #前進するBLEの処理
    print("walk")
    cmd = "bash /home/pi/motion.bash %s %s" % (bcoreMac,"walk")
    os.system(cmd)

def winkIntent():
    #ウィンクするBLEの処理
    print("wink")
    cmd = "bash /home/pi/motion.bash %s %s" % (bcoreMac,"wink")
    os.system(cmd)

def lightIntent():
    #目を光らせるBLEの処理
    print("light")
    cmd = "bash /home/pi/motion.bash %s %s" % (bcoreMac,"light")
    os.system(cmd)


host = "xxxxxxxxxxxxxxxx.ap-northeast-1.amazonaws.com"
rootCAPath = "/home/pi/root-CA.crt"
certificatePath = "/home/pi/certificate.pem.crt"
privateKeyPath = "/home/pi/private.pem.key"
clientId = "MyRaspberryPi"
bcoreMac = "xx:xx:xx:xx:xx:xx"

#robot/〜〜〜となるトピックを全て受信したいので、「+」を指定
topic = "robot/+"

# Init AWSIoTMQTTClient
print("init")
myAWSIoTMQTTClient = None
myAWSIoTMQTTClient = AWSIoTMQTTClient(clientId)
myAWSIoTMQTTClient.configureEndpoint(host, 8883)
myAWSIoTMQTTClient.configureCredentials(rootCAPath, privateKeyPath, certificatePath)

myAWSIoTMQTTClient.configureConnectDisconnectTimeout(30)  # 30 sec
myAWSIoTMQTTClient.configureMQTTOperationTimeout(30)  # 30 sec
myAWSIoTMQTTClient.configureAutoReconnectBackoffTime(1, 128, 20)

# Connect and subscribe to AWS IoT
#AWS_IoTへ接続
myAWSIoTMQTTClient.connect()
print("connect")

#1秒ごとにサブスクライブし続ける（ctrl+Cで終了する）
print("subscribe loop start")
while True:
    myAWSIoTMQTTClient.subscribe(topic, 1, customCallback)
    time.sleep(1)
