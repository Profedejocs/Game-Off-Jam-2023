extends Node2D

var zooming = false
var on_bundle = [0, 0, 0, 0]
@onready var bundles = [$WrldBundle1, $WrldBundle2, $WrldBundle3, $WrldBundle4]
var b1 = null
var b2 = null
var thread: Thread

func select_bundle():
	for i in range(len(on_bundle)):
		if on_bundle[i]:
			#print("set bundle")
			set_bundle(bundles[i])

func _input(event):
	if event.is_action_pressed("select") and $Camera2D.zoom == Vector2(0.25, 0.25):
		thread = Thread.new()
		thread.start(select_bundle.bind())
	if $Player.world != null:
		$Camera2D.position = $Player.world.global_position
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
	if $Player.world != null:
		$Camera2D.position = $Player.world.global_position
	if $Camera2D.zoom == Vector2(0.25, 0.25):
		$Camera2D.position = Vector2.ZERO
	else:
		var cx = max(min(int($Player.position.x/1280)*1280, 0), 1280)
		var cy = max(min(int($Player.position.y/720)*720, 0), 720)
		$Camera2D.position = Vector2(cx, cy)
	zooming = $Camera2D.zoom != Vector2.ONE
	Global.zooming = zooming
	$Camera2D/Control/ProgressBar.value = $Player.hp
	$Camera2D/Control/Label.text = str(max($Player.hp, 0))+" HP"

func _process(delta):
	if Global.tile1 != null and Global.tile2 != null:
		switch_tiles()

func set_bundle(t):
	if b1 != null: b2 = t
	else: b1 = t

func deselect_bundle(t):
	if b1 == t:
		b1 = null
	elif b2 == t:
		b2 = null
	else:
		return null

func _on_bundle_1_mouse_entered(): on_bundle[0] = true
func _on_bundle_2_mouse_entered(): on_bundle[1] = true
func _on_bundle_3_mouse_entered(): on_bundle[2] = true
func _on_bundle_4_mouse_entered(): on_bundle[3] = true
func _on_bundle_1_mouse_exited(): on_bundle[0] = false
func _on_bundle_2_mouse_exited(): on_bundle[1] = false
func _on_bundle_3_mouse_exited(): on_bundle[2] = false
func _on_bundle_4_mouse_exited(): on_bundle[3] = false

func _exit_tree():
	if thread != null and thread.is_started():
		thread.wait_to_finish()
