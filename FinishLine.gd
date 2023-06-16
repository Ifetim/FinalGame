extends Area2D

onready var finish_area := $world/FinishLine



func _ready() -> void:
	#...

	finish_area.connect("body_entered", self, "_on_Finish_body_entered")



func finish_game() -> void:

	set_process(false)

	godot.set_physics_process(false)


# We can't directly connect the body_entered signal to the finish_game()

# function because the body_entered signal requires a callback with a `body`

# parameter.

#

# That's why we need this function.
func _on_FinishLine_body_entered(body):
	.finish_game()
