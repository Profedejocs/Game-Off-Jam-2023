extends Node2D
var mouse_inside = false
var selected = false
func _on_area_2d_mouse_entered(): mouse_inside = true
func _on_area_2d_mouse_exited(): 
	mouse_inside = false
	if selected:
		print("Deselected")
		selected = mouse_inside
func _input(event): if mouse_inside and event.is_action_pressed("select"):
	print("Selected or deselected")
	selected = not selected
