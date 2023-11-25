extends Area2D

var direction = Vector2(1.0,0.0)
var speed = 300.0
var parent = get_parent()

func _ready():
	self.set_meta("type", "bullet")

func _process(delta):
	position = position + speed * direction * delta

func _on_body_entered(body):
	if body != parent:
		queue_free()
