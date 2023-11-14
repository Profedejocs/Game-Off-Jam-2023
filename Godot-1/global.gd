extends Node

var game_over = false

func _physics_process(delta):
	if game_over:
		get_tree().quit()
