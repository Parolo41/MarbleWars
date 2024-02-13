extends CollisionShape2D

var collision_radius : float


func set_radius(radius):
	(shape as CircleShape2D).radius = radius
