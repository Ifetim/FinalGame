extends Sprite

const SPEED_BOOST = 1.7
const BOOST_DURATION = 2.0

var player = KinematicBody2D


func _on_Speedboost_body_entered(body):
	print('entered')
	if body.has_method("speed_boost"):
		player = body
		player.speed_boost(SPEED_BOOST, BOOST_DURATION)
		queue_free()
