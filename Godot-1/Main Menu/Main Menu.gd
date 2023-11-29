extends Control
func _on_begin_pressed(): get_tree().change_scene_to_file("res://Game.tscn")
func _on_credits_pressed(): get_tree().change_scene_to_file("res://Main Menu/Credits.tscn")
func _on_quit_pressed(): get_tree().quit()
