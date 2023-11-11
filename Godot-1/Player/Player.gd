extends CharacterBody2D

var SPEED = 5000

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED
	if Input.is_action_pressed("right"):
		velocity.x += SPEED
	if Input.is_action_pressed("up"):
		velocity.y -= SPEED
	if Input.is_action_pressed("down"):
		velocity.y += SPEED
	velocity *= delta
	#var velx = int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left"))
	#var vely = int(Input.is_action_pressed("up"))-int(Input.is_action_pressed("down"))
	#velocity = Vector2(velx, vely)
	move_and_slide()
