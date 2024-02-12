extends CharacterBody2D

class_name Bullet

@export var radius : float
var color : Color
var direction : Vector2
var tower : Tower

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("BulletCollision").set_radius(radius)


func _process(delta):
	global_position.x = wrapf(global_position.x, 0, 450)
	global_position.y = wrapf(global_position.y, 0, 450)


func _physics_process(delta):
	move_and_collide(direction * delta)
	pass


func _draw():
	draw_circle(Vector2(0, 0), radius, color)
