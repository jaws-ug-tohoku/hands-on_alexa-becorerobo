#!/usr/bin/python3
# -*- coding: utf-8 -*-

from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import os


class AwsIotClient:
    # Initialize
    def __init__(self):
        self.host = os.getenv(
            'ENDPOINT',
            'xxxxxxxxxxxxxxxx.ap-northeast-1.amazonaws.com'
        )
        self.bcoreMac = os.getenv(
            'BCORE_MAC',
            'xx:xx:xx:xx:xx:xx'
        )
        self.rootCAPath = "/home/pi/root-CA.crt"
        self.certificatePath = "/home/pi/certificate.pem.crt"
        self.privateKeyPath = "/home/pi/private.pem.key"
        self.clientId = "MyRaspberryPi"
        self.topic = "robot/+"
        self.cmd = '/home/pi/motion.bash'
        self.myAWSIoTMQTTClient = AWSIoTMQTTClient(self.clientId)
        self.myAWSIoTMQTTClient.configureEndpoint(self.host, 8883)
        self.myAWSIoTMQTTClient.configureCredentials(
            self.rootCAPath,
            self.privateKeyPath,
            self.certificatePath
        )
        self.myAWSIoTMQTTClient.configureConnectDisconnectTimeout(30)  # 30 sec
        self.myAWSIoTMQTTClient.configureMQTTOperationTimeout(30)  # 30 sec
        self.myAWSIoTMQTTClient.configureAutoReconnectBackoffTime(1, 128, 20)

    # Connect and subscribe to AWS IoT
    # AWS_IoTへ接続
    def connect(self):
        print("connect")
        self.myAWSIoTMQTTClient.connect()

    # Custom MQTT message callback
    # 1秒ごとにsubし続けているときにトピックからなにかしら受け取ったら呼ばれる関数
    def customCallback(self, client, userdata, message):
        topic = str(message.topic)
        print(topic)
        if(topic == "robot/walk"):
            self.walkIntent()
        elif(topic == "robot/wink"):
            self.winkIntent()
        elif(topic == "robot/light"):
            self.lightIntent()
        else:
            print("none")

    # 前進するBLEの処理
    def walkIntent(self):
        print("walk")
        cmd = "bash %s %s %s" % (self.cmd, self.bcoreMac, "walk")
        os.system(cmd)

    # ウィンクするBLEの処理
    def winkIntent(self):
        print("wink")
        cmd = "bash %s %s %s" % (self.cmd, self.bcoreMac, "wink")
        os.system(cmd)

    # 目を光らせるBLEの処理
    def lightIntent(self):
        print("light")
        cmd = "bash %s %s %s" % (self.cmd, self.bcoreMac, "light")
        os.system(cmd)

    # 1秒ごとにサブスクライブし続ける（ctrl+Cで終了する）
    def subscribe(self):
        while True:
            self.myAWSIoTMQTTClient.subscribe(self.topic, 1, self.customCallback)


if __name__ == '__main__':
    myAWSIoTMQTTClient = AwsIotClient()
    myAWSIoTMQTTClient.connect()
    myAWSIoTMQTTClient.subscribe()
