extends Node # you always have a node when creating a script

signal stat_change

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stat_change.emit()

var grenade_amount = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stat_change.emit()

var player_vulnerable: bool = true
var health = 60:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100) # limits max health to 100
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
				player_hit_sound.play()
		stat_change.emit()

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout # waits for half a second before continuing
	player_vulnerable = true

var player_pos: Vector2

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound) # adds note to script
