extends Area2D

@onready var sprite = $Sprite_Portal
var entered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://scenes/level4.tscn")
	if (entered == false || entered == true):
		sprite.animation = 'Portal'
	pass



