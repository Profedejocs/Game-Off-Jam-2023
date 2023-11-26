extends Node2D
var mouse_inside = false
var selected = false
var has_player = false
var player = null
func _on_area_2d_mouse_entered(): mouse_inside = true
func _on_area_2d_mouse_exited(): 
	mouse_inside = false
func _process(delta):
	$Area2D/CollisionShape2D.disabled = get_parent().get_parent().get_node("Camera2D").zoom != Vector2(0.5, 0.5)
func _input(event): if mouse_inside and event.is_action_pressed("select") and get_parent().get_parent().get_node("Camera2D").zoom == Vector2(0.5, 0.5):
	print("Selected or deselected")
	selected = not selected
	if Global.tile1 == null:
		Global.tile1 = self
	else:
		Global.tile2 = self

func change_player_pos(pos):
	if player != null:
		var p_loc_pos = Vector2(int(player.global_position.x)%1280, int(player.global_position.y)%720)
		player.global_position = pos+p_loc_pos

func _on_area_2d_body_entered(body):
	if body != null and "Player" in body.name:
		player = body
		player.world = self
		var old_par = player.get_parent()
		if old_par != self and not player == null:
			player.call_deferred("reparent", self)
			#self.add_child(player)
		has_player = true

func _on_area_2d_body_exited(body):
	if body != null and "Player" in body.name:
		player.world = null
		player = null
		has_player = false
