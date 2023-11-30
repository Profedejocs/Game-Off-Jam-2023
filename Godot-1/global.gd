extends Node

var game_over = false
var zooming = false
var tile1 = null
var tile2 = null
func _physics_process(delta):
	if game_over:
		get_tree().change_scene_to_file("res://Main Menu/Game Over.tscn")
