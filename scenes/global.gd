extends Node2D

var enemy_entity = 0
var weather
# Called when the node enters the scene tree for the first time.
func _ready():
	print(enemy_entity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (enemy_entity == 0):
		enable_portal()
	pass
	
func enemy_Count(number):
	enemy_entity = enemy_entity + number
	
func enable_portal():
	$Portal/CollisionShape2D.disabled = false
	$Portal.visible = true
