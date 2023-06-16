extends Area2D

onready var finish_area := get_node("/root/world/FinishLine")
onready var player := get_node("/root/world/Player")



func _ready() -> void:
	finish_area.connect("body_entered", self, "_on_FinishLine_body_entered")






func finish_game() -> void:
	set_process(false)
	player.set_physics_process(false)
	get_tree().change_scene("res://world2.tscn")
	
# We can't directly connect the body_entered signal to the finish_game()

# function because the body_entered signal requires a callback with a `body`

# parameter.

# That's why we need this function.
func _on_FinishLine_body_entered(body):
	print(body)
	if "Player" in body.name:
		finish_game()









# We can't directly connect the body_entered signal to the finish_game()

# function because the body_entered signal requires a callback with a `body`

# parameter.

# That's why we need this function.







