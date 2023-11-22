extends Node2D

func _process(delta):
	$Camera2D/ProgressBar.value = $Player.hp
	$Camera2D/Label.text = str(max($Player.hp, 0))+" HP"
