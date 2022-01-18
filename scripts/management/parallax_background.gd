extends ParallaxBackground

onready var parallax_layer = get_node("ParallaxLayer")

var layer_speed: int = 19.2

func _physics_process(delta: float):
	parallax_layer.motion_offset.x -= layer_speed * delta
