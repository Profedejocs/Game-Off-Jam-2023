extends Node

var game_over = false
var zooming = false
func _physics_process(delta):
	if game_over:
		get_tree().quit()
