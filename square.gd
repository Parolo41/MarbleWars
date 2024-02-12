extends Area2D

class_name Square

var color : Color
var tower : Tower

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _draw():
	draw_rect(Rect2(-4, -4, 8, 8), color.darkened(0.2))


func _on_body_entered(body : Node2D):
	var bullet := body as Bullet
	if not bullet or bullet.tower == tower:
		return
	color = bullet.color
	tower = bullet.tower
	queue_redraw()
	bullet.queue_free()
