extends Area2D

onready var finish_area := get_node("/root/Level2/FinishLine")
onready var player := get_node("/root/Level2/Player")

func _ready() -> void:
	pass


func finish_game() -> void:
	set_process(false)
	player.set_physics_process(false)
	get_tree().change_scene("res://Level1.tscn")
	
	
	
# We can't directly connect the body_entered signal to the finish_game()

# function because the body_entered signal requires a callback with a `body`

# parameter.

# That's why we need this function.
func _on_FinishLine_body_entered(body):
	print(body)
	if "Player" in body.name:
		get_tree().reload_current_scene()
		finish_game()
		

	# We ensure that the label is visible.

	
	









# We can't directly connect the body_entered signal to the finish_game()

# function because the body_entered signal requires a callback with a `body`

# parameter.

# That's why we need this function.







