extends Node2D

var zooming = false
var on_bundle = [0, 0, 0, 0]
@onready var bundles = [$WrldBundle1, $WrldBundle2, $WrldBundle3, $WrldBundle4]
var b1 = null
var b2 = null
@onready var player = get_node("%Player")
func select_bundle():
	for i in range(len(on_bundle)):
		if on_bundle[i]:
			print("set bundle")
			set_bundle(bundles[i])

func _input(event):
	if event.is_action_pressed("select") and $Camera2D.zoom == Vector2(0.25, 0.25):
		select_bundle()
	if player != null and player.world != null:
		$Camera2D.position = player.world.global_position
	if $Camera2D.zoom == Vector2(0.25, 0.25):
		$Camera2D.position = Vector2.ZERO
	if event.is_action_pressed("zoom_out"):
		$Camera2D.zoom.x = max($Camera2D.zoom.x/2, 0.25)
		$Camera2D.zoom.y = max($Camera2D.zoom.y/2, 0.25)
	if event.is_action_pressed("zoom_in"):
		$Camera2D.zoom.x = min($Camera2D.zoom.x*2, 1)
		$Camera2D.zoom.y = min($Camera2D.zoom.y*2, 1)

func switch_tiles():
	var t1_pos = Global.tile1.global_position
	var t2_pos = Global.tile2.global_position
	var t1_par = Global.tile1.get_parent()
	var t2_par = Global.tile2.get_parent()
	Global.tile1.get_parent().remove_child(Global.tile1)
	t2_par.add_child(Global.tile1)
	Global.tile2.get_parent().remove_child(Global.tile2)
	t1_par.add_child(Global.tile2)
	if Global.tile1.has_player:
		Global.tile1.change_player_pos(t2_pos)
	if Global.tile2.has_player:
		Global.tile2.change_player_pos(t1_pos)
	Global.tile2.global_position = t1_pos
	Global.tile1.global_position = t2_pos
	Global.tile1 = null
	Global.tile2 = null

func _physics_process(delta):
	for i in range(len(bundles)):
		bundles[i].get_node("Bundle"+str(i+1)+"/CollisionShape2D").disabled = get_node("Camera2D").zoom != Vector2(0.25, 0.25)
	if player != null and player.world != null:
		$Camera2D.position.x = min(max(player.world.global_position.x, 0), 2560)
		$Camera2D.position.y = min(max(player.world.global_position.y, 0), 1440)
	if $Camera2D.zoom == Vector2(0.25, 0.25):
		$Camera2D.position = Vector2.ZERO
	else:
		pass
		#var cx = min(max(int(player.position.x/1280)*1280, 0), 1280)
		#var cy = min(max(int(player.position.y/720)*720, 0), 720)
		#if $Camera2D.global_position != Vector2(cx, cy):
		#	$Camera2D.global_position = Vector2(cx, cy)
	zooming = $Camera2D.zoom != Vector2.ONE
	Global.zooming = zooming
	if player != null:
		set_bar()
		#$Camera2D/Control/Bar/ProgressBar.value = player.hp
		$Camera2D/Control/NewBar/Label.text = str(max(player.hp, 0))

func _process(delta):
	if Global.tile1 != null and Global.tile2 != null:
		switch_tiles()
	if b1 != null and b1 != null:
		switch_bundles()

func set_bundle(t):
	if b1 != null: b2 = t
	else: b1 = t

func switch_bundles():
	if b1 != null and b2 != null:
		var b1_pos = b1.global_position
		var b2_pos = b2.global_position
		b1.global_position = b2_pos
		b2.global_position = b1_pos
		for i in b1.get_children():
			if not i is Area2D and i.has_player:
				player.position = i.world.position+b2_pos
		for i in b2.get_children():
			if not i is Area2D and i.has_player:
				player.position = i.world.position+b1_pos
		b1 = null
		b2 = null

func deselect_bundle(t):
	if b1 == t:
		b1 = null
	elif b2 == t:
		b2 = null
	else:
		return null

func set_bar():
	pass

func _on_bundle_1_mouse_entered(): on_bundle[0] = true
func _on_bundle_2_mouse_entered(): on_bundle[1] = true
func _on_bundle_3_mouse_entered(): on_bundle[2] = true
func _on_bundle_4_mouse_entered(): on_bundle[3] = true
func _on_bundle_1_mouse_exited(): on_bundle[0] = false
func _on_bundle_2_mouse_exited(): on_bundle[1] = false
func _on_bundle_3_mouse_exited(): on_bundle[2] = false
func _on_bundle_4_mouse_exited(): on_bundle[3] = false
