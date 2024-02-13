extends Node2D

var colors = [
	["Red", "FF0000"],
	["Salmon", "FA8072"],
	["DarkRed", "DarkRed"],
	["Pink", "FFC0CB"],
	["DeepPink", "FF1493"],
	["DarkOrange", "FF8C00"],
	["Yellow", "FFFF00"],
	["Violet", "EE82EE"],
	["Purple", "800080"],
	["Indigo", "4B0082"],
	["GreenYellow", "ADFF2F"],
	["Lime", "00FF00"],
	["Green", "008000"],
	["DarkGreen", "006400"],
	["Olive", "808000"],
	["Teal", "008080"],
	["Cyan", "00FFFF"],
	["Blue", "0000FF"],
	["DarkBlue", "00008B"],
	["Tan", "D2B48C"],
	["Sienna", "A0522D"],
	["Ivory", "FFFFF0"],
	["Silver", "C0C0C0"],
	["DimGray", "696969"],
	["DarkGray", "303030"],
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var tower_scene : PackedScene = load("res://Scenes/tower.tscn")
	var square_scene : PackedScene = load("res://Scenes/square.tscn")
	
	var towers = get_node("Towers")
	var square_grid = get_node("SquareGrid")
	
	colors.shuffle()
	var color_index = 0
	
	for n in range(1, 6):
		for m in range(1, 6):
			var new_tower = tower_scene.instantiate() as Tower
			towers.add_child(new_tower)
			new_tower.position = Vector2((n * 90) - 45, (m * 90) - 45)
			new_tower.color_name = colors[color_index][0]
			new_tower.set_color(Color(colors[color_index][1]))
			color_index += 1
	
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
