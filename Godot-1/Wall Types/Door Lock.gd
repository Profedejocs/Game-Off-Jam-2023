extends StaticBody2D
@export var locked: bool = false
func _process(delta): 
	$CollisionShape2D.disabled = not locked
	$WallUp.visible = locked
