extends StaticBody2D

var current_weather = 'none'

# Called when the node enters the scene tree for the first time.
func _ready():
	if current_weather == 'none':
		$rain.visible = false
		$raincolor.visible = false
	if current_weather == 'rain':
		$rain.visible = true
		$raincolor.visible = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Global_var = get_tree().get_first_node_in_group("Global")
	Global_var.weather = current_weather
	if current_weather == 'none':
		$rain.visible = false
		$raincolor.visible = false
	if current_weather == 'rain':
		$rain.visible = true
		$raincolor.visible = false
	pass


func _on_timer_timeout():
	if current_weather == 'none':
		current_weather = 'rain'
		print('rain')
		await get_tree().create_timer(60).timeout
		$Timer.start()
	elif current_weather == 'rain':
		current_weather = 'none'
		print('none')
		await get_tree().create_timer(60).timeout
		$Timer.start()
	pass # Replace with function body.
