# coding: UTF-8

import json
import boto3

iot = boto3.client('iot-data')

def lambda_handler(event, context):

	#自身のAlexaのアプリケーションIDを記述
	myAppID = "amzn1.ask.skill.xxxxxxxxxxxxx"

	if (event['session']['application']['applicationId'] != myAppID):
		raise ValueError("Invalid Application ID")

	if(event['request']['type'] == "IntentRequest"):
		speak_alexa = on_intent(event['request'], event['session'])
		return speak_alexa

	return

def on_intent(intent_request, session):
	intent = intent_request['intent']
	intent_name = intent_request['intent']['name']

	if intent_name == "walkIntent":
		return walk_intents_flow(intent, session)
	elif intent_name == "winkIntent":
		return wink_intents_flow(intent, session)
	elif intent_name == "lightIntent":
		return light_intents_flow(intent, session)
	else:
		raise ValueError("Invalid intent")

def walk_intents_flow(intent, session):

	output_text = "前進ですね。わかりました。"

	topic = 'robot/walk'

	payload = {
		"message": "walk!"
	}

	iot.publish(
		topic = topic,
		qos = 0,
		payload = json.dumps(payload, ensure_ascii=False)
	)

	return resp_text_message(output_text)

def wink_intents_flow(intent, session):

	output_text = "ウィンクですね。わかりました。"

	topic = 'robot/wink'
	
	payload = {
		"message": "wink!"
	}

	iot.publish(
		topic = topic,
		qos = 0,
		payload = json.dumps(payload, ensure_ascii=False)
	)

	return resp_text_message(output_text)

def light_intents_flow(intent, session):

	output_text = "目を光らせるですね。わかりました。"

	topic = 'robot/light'
	
	payload = {
		"message": "light!"
	}

	iot.publish(
		topic = topic,
		qos = 0,
		payload = json.dumps(payload, ensure_ascii=False)
	)

	return resp_text_message(output_text)


def resp_text_message(speech_message):
	return {
		"version": "1.0",
		"sessionAttributes": {},
		"response": {
			'outputSpeech': {
				'type': 'PlainText',
				'text': speech_message
			},
			'card': {
				'type': 'Simple',
				"content": "カードの内容：" + speech_message,
				"title": "デバッグ"
			},
			'reprompt': {
				'outputSpeech': {
					'type': 'PlainText',
					'text': speech_message
				}
			},
			'shouldEndSession': True
		}
	}
