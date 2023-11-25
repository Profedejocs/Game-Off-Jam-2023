extends CharacterBody2D

@export var hp = 3
var speed = 120
var aim_speed = 1
var current_dlr = "none"
var mouse_dir = 0
@onready var anim = $AnimatedSprite2D
func  _physics_process(delta):
	mouse_dir = get_angle_to(get_global_mouse_position())
	player_movement(delta)
	

func player_movement(delta):
	
	if Input.is_action_pressed("right"):
		current_dlr = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		current_dlr = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0	
	elif Input.is_action_pressed("down"):
		current_dlr = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif  Input.is_action_pressed("up"):
		current_dlr = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0		
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0	
	
	
	move_and_slide()	

func play_anim(movement):
	var dlr = current_dlr
	
	if dlr == "right":
		anim.flip_h = true
		if movement == 1 :
			anim.play ("side_walk")
		elif movement == 0 :
			anim.play ("side_idle")	
	if dlr == "left":
		anim.flip_h = false
		if movement == 1 :
			anim.play ("side_walk")
		elif movement == 0 :
			anim.play ("side_idle")	
					
	if dlr == "down":
		anim.flip_h = false
		if movement == 1 :
			anim.play ("front_walk")
		elif movement == 0 :
			anim.play ("idle")
	if dlr == "up":
		anim.flip_h = false
		if movement == 1 :
			anim.play ("back_walk")
		elif movement == 0 :
			anim.play ("back_idle")	

func _on_area_2d_body_entered(body):
	if body != null and "Enemy" in body.name:
		hp -= 1
	if hp <= 0:
		Global.game_over = true

func _input(event):
	if event.is_action_pressed("shoot") and not Global.zooming:
		fire(self.mouse_dir)

func fire(angle):
	var direction = Vector2(1.0, 0.0).rotated(angle).normalized()
	var bullet = load("res://Player/Bullet/Bullet.tscn").instantiate()
	bullet.global_position = $Gun/ShootingPoint.global_position
	bullet.direction = direction
	bullet.parent = self
	get_parent().add_child(bullet)
