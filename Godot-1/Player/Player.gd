extends CharacterBody2D

@export var hp = 3
var SPEED = 5000

func _physics_process(delta):
	print(hp)
	#fire(self.global_rotation)
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
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body != null and "Enemy" in body.name:
		hp -= 1
	if hp <= 0:
		Global.game_over = true

func _input(event):
	if event.is_action_pressed("shoot"):
		fire(self.global_rotation)

func fire(angle):
	var direction = Vector2(1.0, 0.0).rotated(angle).normalized()
	var bullet = load("res://Player/Bullet/Bullet.tscn").instantiate()
	bullet.global_position = $Gun/ShootingPoint.global_position
	bullet.direction = direction
	get_parent().add_child(bullet)
