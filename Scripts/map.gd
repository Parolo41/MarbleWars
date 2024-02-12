extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var square_scene : PackedScene = load("res://Scenes/square.tscn")
	
	var towers = get_node("Towers")
	var square_grid = get_node("SquareGrid")
	
	for node in towers.get_children():
		var tower = node as Tower
		if not tower:
			continue
		
		for n in range(-4, 5):
			for m in range(-4, 5):
				var new_square = square_scene.instantiate() as Square
				square_grid.add_child(new_square)
				new_square.position = tower.position + Vector2(n * 10, m * 10)
				new_square.color = tower.color
				new_square.tower = tower
				
				if n == 0 and m == 0:
					tower.home_square = new_square


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
