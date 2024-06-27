extends CharacterBody2D

var SPEED = 180
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $character/Area2D/Sprite2D
@onready var colision = $CollisionShape2D
@onready var colision_attack = $character/Area2D
@onready var attack_detector = $character/Attack_Detector
@onready var attack_detector_2D = $character/Attack_Detector/Attack_Detector_2d
@onready var label = $Health
var player_chase = false
var player = null
var enemy_dmg = 10

var player_found : bool = false
var attack = false
var hp = 100 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var Global_var = get_tree().get_first_node_in_group("Global")
	player = get_tree().get_first_node_in_group("player")
	Global_var.enemy_Count(1)

func attack_func():
	await get_tree().create_timer(0.45).timeout
	attack_detector_2D.call_deferred("set", "disabled", true)
	#await get_tree().create_timer(0.45).timeout
	#$character/Area2D/CollisionShape2D_Area2d.call_deferred("set", "disabled", true)


func _physics_process(delta):
	if player_chase:
		var x_before = position.x
		position += (player.position - position) / SPEED
		var x_after = position.x
		if x_before > x_after and not attack:
			sprite_2d.animation = 'walking'
			attack_detector.scale.x = -1
			colision_attack.scale.x = -1
			colision.position.x = -63
			label.position.x = -225
		elif not attack:
			sprite_2d.animation = 'walking'
			attack_detector.scale.x = 1
			colision_attack.scale.x = 1
			colision.position.x = 63
			label.position.x = -98
		
	if velocity.x == 0 and not attack:
		sprite_2d.animation = 'idle'
	
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	var direction = 0
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func take_damage(damage):
	if hp <= 0:
		var Global_var = get_tree().get_first_node_in_group("Global")
		Global_var.enemy_Count(-1)
		var Hit = get_tree().get_first_node_in_group("Hit")
		Hit.sprite_steal(3)
		queue_free()
	hp -= damage
	await get_tree().create_timer(0.45).timeout
	print("Dano Computado")
	print(hp)

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		player_chase = false

func _on_attack_detector_body_entered(body):
	body.protag_take_damage(enemy_dmg)
	await get_tree().create_timer(0.45).timeout
	if body.is_in_group("player"):
		attack = true
		sprite_2d.animation = 'attack'
		#attack_func()



func _on_area_2d_body_entered(body):
		pass


func _on_timer_timeout():
	if attack == true:
		attack_func()
		attack_detector_2D.call_deferred("set", "disabled", false)
		attack = false
	elif attack == false:
		attack = true
	pass # Replace with function body.


func _on_attack_detector_body_exited(body):
	attack = false
	pass # Replace with function body.
