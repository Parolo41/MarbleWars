extends StaticBody2D

var colors : PackedColorArray


func _ready():
	colors.resize(6)
	colors.fill(Color.DIM_GRAY)


func _draw():
	draw_polygon(get_node("DividerCollision").polygon, colors)
