extends CharacterBody2D

var hp = 1
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

func _on_area_2d_area_entered(area):
	if area != null and "Bullet" in area.name:
		hp -= 1
		area.queue_free()
	if hp <= 0: queue_free()
