extends KinematicBody2D

var motion = Vector2()
const FOLLOW_SPEED = 70
var follow_player = true

func _ready():
	pass

func _physics_process(delta: float) -> void:
	if follow_player:
		var player = get_parent().get_node("Player")
		position += (player.position - position) / FOLLOW_SPEED
		look_at(player.position)

	move_and_collide(motion)

func _on_Area2D_body_entered(body):
	if 'bullet' in body.name:
		queue_free()
