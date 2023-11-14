extends CharacterBody2D

var speed = 10000
var dir = -1

func _physics_process(delta):
	velocity = Vector2.ZERO
	if dir == -1:
		velocity = Vector2(-speed, 0)
	else:
		velocity = Vector2(speed, 0)
	velocity *= delta
	move_and_slide()

func _on_area_2d_body_entered(body):
	dir = -dir
