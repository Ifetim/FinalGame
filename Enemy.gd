extends KinematicBody2D

var motion = Vector2()
const FOLLOW_SPEED = 70
var follow_player = true

var follow_timer = Timer.new()
const FOLLOW_DISTANCE = 700


var player = null

func _ready():
	follow_timer.wait_time = 3.0
	follow_timer.one_shot = true
	follow_timer.connect("timeout", self, "_resume_following_player")
	add_child(follow_timer)

	
func _physics_process(delta: float) -> void:
	var player = get_parent().get_node("Player")
	if player:
		var distance = position.distance_to(player.position)
		if follow_player and distance <= FOLLOW_DISTANCE:
			position += (player.position - position) / FOLLOW_SPEED
			look_at(player.position)	
		elif distance <= FOLLOW_DISTANCE:
			follow_player = true

	move_and_collide(motion)
	

func _on_Area2D_body_entered(body):
	if 'bullet' in body.name:
		queue_free()
	if body.is_in_group("player"):
		player = body

func _on_Player_body_exited(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"):
		player = null

#func _on_InvisibilityPotion_body_entered():
#	follow_player = false
#	var potionTimer = Timer.new()
#	potionTimer.wait_time = 3.0
#	potionTimer.one_shot = true
#	potionTimer.connect("timeout", self, "_resume_following_player")
#	add_child(potionTimer)
#	potionTimer.start()

func stop_following_player():
	follow_player = false
	follow_timer.start()
	
func _resume_following_player():
	follow_player = true

		

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player = null


		
