extends KinematicBody2D

var motion = Vector2()
const FOLLOW_SPEED = 70
var follow_player = true


func _ready():
	get_parent().connect("potion_picked_up", self, "_on_PotionPickedUp")

	
func _physics_process(delta: float) -> void:
	if follow_player:
		var player = get_parent().get_node("Player")
		if player:
			position += (player.position - position) / FOLLOW_SPEED
			look_at(player.position)

	move_and_collide(motion)


func _on_Area2D_body_entered(body):
	if 'bullet' in body.name:
		queue_free()

		

	
func _on_PotionPickedUp():
	follow_player = false
	var potionTimer = Timer.new()
	potionTimer.wait_time = 3.0
	potionTimer.one_shot = true
	potionTimer.connect("timeout", self, "_resume_following_player")
	add_child(potionTimer)
	potionTimer.start()

func _resume_following_player():
	follow_player = true

func _on_Potion_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("potion_picked_up")
		body.queue_free()



	
