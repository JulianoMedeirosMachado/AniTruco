extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Global_var = get_tree().get_first_node_in_group("Global")
	self.text = str("Enemy Number: ") + str(Global_var.enemy_entity)
	if (Global_var.enemy_entity == 0):
		self.text = str("Congrats! A portal has opened")
