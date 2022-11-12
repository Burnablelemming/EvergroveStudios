extends Node2D

onready var music = $music
onready var musicTrigger = $musicTrigger

func _ready():
	pass

func _on_musicTrigger_body_entered(_body):
	music.play()
