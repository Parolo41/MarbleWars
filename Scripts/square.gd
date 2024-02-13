extends Area2D

class_name Square

var color : Color
var tower : Tower


func _draw():
	draw_rect(Rect2(-4, -4, 8, 8), color.darkened(0.2))
