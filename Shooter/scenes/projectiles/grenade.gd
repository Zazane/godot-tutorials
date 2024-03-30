extends RigidBody2D

const speed  = 750
var explosion_active: bool = false
var explosion_radius: int = 400

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true

func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for traget in targets:
			var in_range = traget.global_position.distance_to(global_position) < explosion_radius
			if "hit" in traget and in_range:
				traget.hit()
