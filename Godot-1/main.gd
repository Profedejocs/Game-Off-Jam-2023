extends Node2D

func _process(delta):
	$Player/Camera2D/ProgressBar.value = $Player.hp
	$Player/Camera2D/Label.text = str(max($Player.hp, 0))+" HP"
