extends KinematicBody2D

var motion = Vector2()
const FOLLOW_SPEED = 60
var follow_player = true

var follow_timer = Timer.new()
const FOLLOW_DISTANCE = 500

var player = null
var playerScore = null 
signal enemy_killed

func _ready():
	pass
	
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
		emit_signal("enemy_killed")
		queue_free()
