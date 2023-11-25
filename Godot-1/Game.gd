extends Node2D

var zooming = false
func _input(event):
	if event.is_action_pressed("zoom_out"):
		$Camera2D.zoom.x = max($Camera2D.zoom.x/2, 0.25)
		$Camera2D.zoom.y = max($Camera2D.zoom.y/2, 0.25)
	if event.is_action_pressed("zoom_in"):
		$Camera2D.zoom.x = min($Camera2D.zoom.x*2, 1)
		$Camera2D.zoom.y = min($Camera2D.zoom.y*2, 1)

func _process(delta):
	if $Camera2D.zoom == Vector2.ONE:
		zooming = false
		$Camera2D.position.x = int($Player.global_position.x/1280)*1280
		$Camera2D.position.y = int($Player.global_position.y/720)*720
	else:
		zooming = true
		$Camera2D.position = Vector2.ZERO
	Global.zooming = zooming
	$Control/ProgressBar.value = $Player.hp
	$Control/Label.text = str(max($Player.hp, 0))+" HP"
