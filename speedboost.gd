extends Area2D

const SPEED_BOOST = 2.0
const BOOST_DURATION = 3.0

var player = get_node("/root/world/Player") as KinematicBody2D

#func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
#	print('entered')
#	if body.has_method("speed_boost"):
#		player = body
#		player.speed_boost(SPEED_BOOST, BOOST_DURATION)
#		queue_free()
