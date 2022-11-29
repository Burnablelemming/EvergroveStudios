extends Control

onready var background = $background

func _process(_delta):
	background.scroll_base_offset -= Vector2(1,0)
