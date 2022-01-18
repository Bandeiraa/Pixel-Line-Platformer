extends Area2D

onready var sprite = get_node("Sprite")

var direction = 1

export(int) var speed
export(int) var damage

func _ready():
	if direction == -1:
		sprite.flip_h = true
		
		
func _physics_process(_delta):
	translate(Vector2(speed * direction, 0))


func on_body_entered(body):
	body.update_health(damage)
	queue_free()


func on_screen_exited():
	queue_free()
