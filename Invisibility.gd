extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


onready var enemy := get_node("/root/world/Enemy")

func _on_InvisibilityPotion_body_entered(body) -> void:
	print(body)
	if body.is_in_group("player"):
		print(body)
		body.stop_following_player()
		var potionTimer = Timer.new()
		potionTimer.wait_time = 3.0
		potionTimer.one_shot = true
		potionTimer.connect("timeout", body, "_resume_following_player")
		body.add_child(potionTimer)
		potionTimer.start()
	queue_free()
	
func _resume_following_player() -> void:
	enemy._resume_following_player()
