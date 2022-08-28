extends Node2D

func _ready():
	update()

func _draw():
	draw_line(Vector2(0,0), Vector2(1000, 1000), Color(255,255,255), 10)
