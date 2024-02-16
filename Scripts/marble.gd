extends RigidBody2D

class_name Marble

@export var radius : float
var tower : Tower


# Called when the node enters the scene tree for the first time.
func _ready():
	(get_node("MarbleCollision").shape as CircleShape2D).radius = radius


func _draw():
	draw_circle(Vector2(0,0), radius, tower.color)
