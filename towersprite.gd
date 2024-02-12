extends Node2D

class_name TowerSprite

var color : Color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(delta)


func _draw():
	draw_rect(Rect2(-2, -6, 4, 6), color)
	draw_rect(Rect2(-3, -7, 6, 8), color.darkened(0.5), false)
