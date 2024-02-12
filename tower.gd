extends Node2D

class_name Tower

var color : Color

var home_square : Square

var action_timer : float = 0
var bullets_loaded : int = 1

var firing = false

var bullet_scene : PackedScene
var tower_sprite : TowerSprite

var timer_label : Label
var bullet_count_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	color = Color((randi() % 100) as float / 100, (randi() % 100) as float / 100, (randi() % 100) as float / 100)
	
	bullet_scene = load("res://bullet.tscn")
	tower_sprite = get_node("TowerSprite")
	tower_sprite.color = color
	
	timer_label = get_node("Timer")
	bullet_count_label = get_node("BulletCount")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firing:
		if action_timer <= 0:
			fire_bullet()
			bullets_loaded -= 1
			action_timer += 0.05
		
		if bullets_loaded < 1:
			bullets_loaded = 1
			firing = false
			action_timer += (randi() % 25 + 25) / 10
		
		action_timer -= delta
		
		bullet_count_label.text = "%d" % bullets_loaded
	else:
		if action_timer <= 0:
			if randi() % 10 >= 6:
				double_bullets()
				action_timer += (randi() % 25 + 25) / 10
			else:
				begin_firing()
				action_timer += 0.05
		
		action_timer -= delta
		
		timer_label.text = "%.02f" % action_timer


func double_bullets():
	bullets_loaded *= 2
	bullet_count_label.text = "%d" % bullets_loaded


func begin_firing():
	firing = true


func fire_bullet():
	var new_bullet = bullet_scene.instantiate() as Bullet
	new_bullet.tower = home_square.tower
	new_bullet.color = home_square.color
	new_bullet.direction = Vector2.UP.rotated(tower_sprite.rotation) * 100
	add_child(new_bullet)
