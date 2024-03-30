extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP # overriden in level to go with player direction


func _ready():
	$SelfDestructTimer.start()


func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	# if body.has_method("hit"):
	if "hit" in body: # can check method or property
		body.hit()
	queue_free() # destroying a node


func _on_self_destruct_timer_timeout():
	queue_free()
