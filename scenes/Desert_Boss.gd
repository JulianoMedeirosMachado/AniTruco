extends Node2D

var weather = 'none'
var enemy_entity = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_update()
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (enemy_entity == 0):
		enable_portal()
	pass
	
func enemy_Count(number):
	enemy_entity = enemy_entity + number
	
func sprite_update():
	var player = get_node("CharacterBody2D")
	player.sprite_new_level(4)
	
func enable_portal():
	$Portal/CollisionShape2D.disabled = false
	$Portal.visible = true
