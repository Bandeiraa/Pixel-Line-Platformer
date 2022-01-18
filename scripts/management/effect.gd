extends AnimatedSprite

func _ready():
	play("idle")
	
	
func on_animation_finished():
	queue_free()
