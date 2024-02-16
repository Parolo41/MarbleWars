extends Node2D

class_name Tower

signal finished_firing(tower : Tower)

var color_name : String
var color : Color

var home_square : Square

var bullets_loaded : int = 1
var action_timer : float = 0.0

var firing = false

var bullet_scene : PackedScene
var tower_sprite : TowerSprite
var bullet_count_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_scene = load("res://Scenes/bullet.tscn")
	tower_sprite = get_node("TowerSprite") as TowerSprite
	bullet_count_label = get_node("BulletCountLabel")
	
	tower_sprite.color = color
	
	bullet_count_label.text = "1"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firing:
		if action_timer <= 0:
			fire_bullet()
			bullets_loaded -= 1
			action_timer += 0.05
			bullet_count_label.text = str(bullets_loaded)
		
		if bullets_loaded < 1:
			bullets_loaded = 1
			firing = false
			bullet_count_label.text = str(bullets_loaded)
			finished_firing.emit()
		
		action_timer -= delta


func double_bullets():
	bullets_loaded *= 2
	bullet_count_label.text = str(bullets_loaded)


func begin_firing():
	firing = true


func fire_bullet():
	var new_bullet = bullet_scene.instantiate() as Bullet
	new_bullet.tower = home_square.tower
	new_bullet.color = home_square.color
	new_bullet.direction = Vector2.UP.rotated(tower_sprite.rotation) * 100
	
	add_child(new_bullet)
