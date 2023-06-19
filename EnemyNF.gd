extends KinematicBody2D

var motion = Vector2()
const FOLLOW_SPEED = 60
var follow_player = true

var follow_timer = Timer.new()
const FOLLOW_DISTANCE = 700

var player = null
var shotsCount = 0 
var playerScore = 0
signal enemy_killed


func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var player = get_parent().get_node("Player")
	if player:
		position += (player.position - position) / FOLLOW_SPEED
		look_at(player.position)
	move_and_collide(motion)


func _on_Area2D_body_entered(body):
	if 'bullet' in body.name:
		shotsCount += 1
		if shotsCount >= 2:
			print("killed")
			emit_signal("enemy_killed")
			queue_free()
