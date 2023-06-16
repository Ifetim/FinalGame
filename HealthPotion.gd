extends Sprite

export var healingAmount: int = 25
func _on_HealthPotion_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.health <= 80:
			body.health += 20
			body.healthBar.value = body.health
		elif body.health > 80 and body.health < 100:
			body.health += (100 - body.health)
			body.healthBar.value = body.health
		else:
			body.healthBar.value = body.health
		queue_free()




