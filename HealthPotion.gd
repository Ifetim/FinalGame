extends Area2D

export var healingAmount: int = 25

func _on_HealthPotion_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.health <= 80:
			body.health += 20
			body.healthBar.set_value(body.health)
		elif body.health > 80 and body.health < 100:
			body.health += (100 - body.health)
			body.healthBar.set_value(body.health)
		else:
			pass
			body.healthBar.set_value(body.health)
	
		queue_free()
