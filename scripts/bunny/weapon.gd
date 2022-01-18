extends Area2D

func on_body_entered(body):
	body.change_sprite()
	queue_free()
