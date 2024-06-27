extends CharacterBody2D

var SPEED = 900.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $character/Area2D/Sprite2D
@onready var colision = $CollisionShape2D
@onready var colision_attack = $character/Area2D
@onready var label = $Health
@onready var power_up = $power_up
var attack = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var protag_dmg = 100
var hp = 100
var updater = null


func _ready():
	pass

func sprite_steal(newsprite):
	match newsprite:
		1:
			if updater != "6_clubs" and updater != "1_cups" and updater != "7_gold" and updater != "7_spades" and updater != "1_clubs":
				if sprite_2d != $"character/Area2D/5_gold":
					sprite_2d.visible = false
					sprite_2d = $"character/Area2D/5_gold"
					sprite_2d.visible = true
					power_up.visible = true
					await get_tree().create_timer(1.5).timeout
					power_up.visible = false
					hp += 5
					updater = "5_gold"
		2:
			if updater != "6_clubs" and updater != "1_cups" and updater != "7_gold" and updater != "7_spades" and updater != "1_clubs":
				if sprite_2d != $"character/Area2D/6_clubs":
					sprite_2d.visible = false
					sprite_2d = $"character/Area2D/6_clubs"
					sprite_2d.visible = true
					power_up.visible = true
					await get_tree().create_timer(1.5).timeout
					power_up.visible = false
					hp += 7
					updater = "6_clubs"
		3:
			if updater != "1_cups" and updater != "7_gold" and updater != "7_spades":
				if sprite_2d != $"character/Area2D/1_cups":
					sprite_2d.visible = false
					sprite_2d = $"character/Area2D/1_cups"
					sprite_2d.visible = true
					power_up.visible = true
					await get_tree().create_timer(1.5).timeout
					power_up.visible = false
					hp += 10				
					updater = "1_cups"
		4: 
			if updater != "6_clubs" and updater != "5_gold" and updater != "7_gold" and updater != "7_spades":
				if sprite_2d != $"character/Area2D/7_gold":
					sprite_2d.visible = false
					sprite_2d = $"character/Area2D/7_gold"
					sprite_2d.visible = true
					power_up.visible = true
					await get_tree().create_timer(1.5).timeout
					power_up.visible = false
					hp += 20
					updater = "7_gold"
		5: 
			if updater != "6_clubs" and updater != "5_gold" and updater != "1_cups" and updater != "7_spades":
				if sprite_2d != $"character/Area2D/7_spades":
					sprite_2d.visible = false
					sprite_2d = $"character/Area2D/7_spades"
					sprite_2d.visible = true
					power_up.visible = true
					await get_tree().create_timer(1.5).timeout
					power_up.visible = false
					hp += 30
					updater = "7_spades"
				
		6: 
			if updater != "6_clubs" and updater != "5_gold" and updater != "1_cups" and updater != "7_gold":
				if sprite_2d != $"character/Area2D/1_clubs":
					sprite_2d.visible = false
					sprite_2d = $"character/Area2D/1_clubs"
					sprite_2d.visible = true
					power_up.visible = true
					await get_tree().create_timer(1.5).timeout
					power_up.visible = false
					hp += 40
					updater = "1_clubs"
				
				
func sprite_new_level(newsprite):
	match newsprite:
		3:
				sprite_2d.visible = false
				sprite_2d = $"character/Area2D/1_cups"
				sprite_2d.visible = true
				updater = "1_cups"
		4:
				sprite_2d.visible = false
				sprite_2d = $"character/Area2D/7_gold"
				sprite_2d.visible = true
				hp += 30
				updater = "7_gold"
		5:
				sprite_2d.visible = false
				sprite_2d = $"character/Area2D/7_spades"
				sprite_2d.visible = true
				hp += 40
				updater = "7_spades"
		6:
				sprite_2d.visible = false
				sprite_2d = $"character/Area2D/1_clubs"
				sprite_2d.visible = true
				hp += 50
				updater = "1_clubs"
		7:
				sprite_2d.visible = false
				sprite_2d = $"character/Area2D/1_spades"
				sprite_2d.visible = true
				

	
	
func attack_func():
	if not attack:
		attack = true
		sprite_2d.animation = 'attack'
		$character/Area2D/CollisionShape2D_Area2d.call_deferred("set", "disabled", false)
		await get_tree().create_timer(0.45).timeout
		$character/Area2D/CollisionShape2D_Area2d.call_deferred("set", "disabled", true)
		attack = false
		print(attack)


func _physics_process(delta):
	var Global_var = get_tree().get_first_node_in_group("Global")
	if velocity.x > 1 or velocity.x < -1:
		sprite_2d.animation = 'walking'
		
	if velocity.x == 0 and not attack:
		sprite_2d.animation = 'idle'
		
	if Input.is_action_just_pressed("ataque"):    
		attack_func()
		
	var isLeft = velocity.x < 0
	if isLeft:
		colision_attack.scale.x = -1
		colision.position.x = -63
		label.position.x = -225
		power_up.position.x = -225
	
	var isRight = velocity.x > 0
	if isRight:
		colision_attack.scale.x = 1
		colision.position.x = 63
		label.position.x = -98
		power_up.position.x = -99
	
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * 3

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if Global_var.weather == "rain":
		SPEED = 400
	else:
		SPEED = 900

func _on_area_2d_body_entered(body):
	if body.is_in_group("Hit") and body.has_method('take_damage'):
		body.take_damage(protag_dmg)
		
func protag_take_damage(damage):
	await get_tree().create_timer(0.45).timeout
	hp -= damage
	print("Dano Computado")
	print(hp)
	if hp < 0:
		get_tree().change_scene_to_file("res://Died_Screen.tscn")
