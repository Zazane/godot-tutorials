extends CharacterBody2D

signal laser_detected(pos, direction)
signal grenade_detected(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed # automatically includes delta
	move_and_slide()
	Globals.player_pos = global_position
	
	# rotate - always look at the mouse
	look_at(get_global_mouse_position())

	var player_direction = (get_global_mouse_position() - position).normalized()

	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		# randomly select marker 2D for laser starting point
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$Timer.start()
		# emit position selected
		laser_detected.emit(selected_laser.global_position, player_direction)
		# local position is relative to parent, globabl position is independent from any parent
	
	# granade shooting input
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		# position is player position - vector from mouse - vector from player position
		# for example, player(200,100) mouse(300,200) -> result(100,100) - 100px to right and 100px up
		# we will need to multiply this by speed -  it will be a huge inconsistant number, so we need it normalized
		grenade_detected.emit(pos, player_direction)

func hit():
	Globals.health -= 10

func _on_timer_timeout():
	can_laser = true # Replace with function body.


func _on_grenade_reload_timer_timeout():
	can_grenade = true # Replace with function body.
