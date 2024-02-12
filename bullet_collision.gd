extends CollisionShape2D

var collision_radius : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_radius(radius):
	(shape as CircleShape2D).radius = radius
