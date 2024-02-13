extends Node2D

var tower_scene : PackedScene = load("res://Scenes/tower.tscn")
var square_scene : PackedScene = load("res://Scenes/square.tscn")

var tower_grid : Node2D
var square_grid : Node2D

var towers = []
var squares = []

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
	tower_grid = get_node("TowerGrid")
	square_grid = get_node("SquareGrid")
	
	colors.shuffle()
	
	setup_towers()
	setup_squares()


func _draw():
	for n in range(0, 45):
		for m in range(0, 45):
			var current_square = squares[n][m] as Square
			var right_square = squares[wrapf(n + 1, 0, 45)][m] as Square
			var down_square = squares[n][wrapf(m + 1, 0, 45)] as Square
			
			if current_square.tower != right_square.tower:
				draw_rect(Rect2(current_square.position.x + 4, current_square.position.y + -5, 2, 10), Color.BLACK)
			
			if current_square.tower != down_square.tower:
				draw_rect(Rect2(current_square.position.x + -5, current_square.position.y + 4, 10, 2), Color.BLACK)


func _on_body_entered(body : Node2D, square : Square):
	var bullet := body as Bullet
	if not bullet or bullet.tower == square.tower:
		return
	square.color = bullet.color
	square.tower = bullet.tower
	square.queue_redraw()
	bullet.queue_free()
	
	queue_redraw()


func setup_towers():
	var color_index = 0
	
	for n in range(1, 6):
		var tower_row = []
		
		for m in range(1, 6):
			var new_tower = tower_scene.instantiate() as Tower
			new_tower.position = Vector2((n * 90) - 45, (m * 90) - 45)
			new_tower.color_name = colors[color_index][0]
			new_tower.color = colors[color_index][1]
			
			tower_grid.add_child(new_tower)
			tower_row.append(new_tower)
			
			color_index += 1
		towers.append(tower_row)


func setup_squares():
	for n in range(0, 45):
		var square_row = []
		
		for m in range(0, 45):
			var local_tower = towers[floor(n / 9)][floor(m / 9)] as Tower
			var new_square = square_scene.instantiate() as Square
			new_square.position = Vector2((n * 10) + 5, (m * 10) + 5)
			new_square.color = local_tower.color
			new_square.tower = local_tower
			
			if m % 9 == 4 and n % 9 == 4:
				local_tower.home_square = new_square
			
			new_square.body_entered.connect(_on_body_entered.bind(new_square))
			
			square_grid.add_child(new_square)
			square_row.append(new_square)
		squares.append(square_row)
