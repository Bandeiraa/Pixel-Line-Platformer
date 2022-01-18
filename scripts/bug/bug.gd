extends KinematicBody2D

onready var sprite = get_node("Sprite")
onready var raycast = get_node("RayCast2D")

var velocity: Vector2

export(PackedScene) var hit_effect
export(PackedScene) var death_effect

export(int) var speed
export(int) var damage
export(int) var health

export(bool) var ground_enemy

var direction = 1

var player_ref = null

func _physics_process(_delta):
	if ground_enemy:
		on_wall()
		velocity.x = speed * direction
		
	elif player_ref != null and not ground_enemy:
		var dir: Vector2 = (player_ref.global_position - global_position)
		if dir.length() < 5:
			velocity = Vector2.ZERO
		else:
			velocity = dir.normalized() * speed
			
		verify_direction()
			
	elif not ground_enemy:
		velocity = Vector2.ZERO
		verify_direction()
		
	velocity = move_and_slide(velocity)
		
		
func on_wall():
	if is_on_wall() or not raycast.is_colliding():
		direction *= -1
		scale.x *= -1
		
		
func verify_direction():
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
		
		
func update_health(amount):
	health -= amount
	if health <= 0:
		spawn_effect(death_effect)
		Globals.enemies_count += 1
		queue_free()
	else:
		spawn_effect(hit_effect)
		
		
func spawn_effect(target_effect):
	var effect = target_effect.instance()
	effect.global_position = global_position
	get_tree().root.call_deferred("add_child", effect)
	
	
func on_body_entered(body):
	player_ref = body


func on_body_exited(_body):
	player_ref = null
