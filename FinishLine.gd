extends Area2D

onready var finish_area := get_node("/root/Level1/FinishLine")
onready var player := get_node("/root/Level1/Player")
onready var label := get_node("/root/Level1/CanvasLayer2/Label")
var labelTimer: Timer
var playerTimer: Timer

func _ready() -> void:
	finish_area.connect("body_entered", self, "_on_FinishLine_body_entered")
	
	labelTimer = Timer.new()
	labelTimer.wait_time = 3.0
	labelTimer.one_shot = true
	labelTimer.connect("timeout", self, "_on_LabelTimer_timeout")
	label.visible = false
	add_child(labelTimer)
	get_tree().get_root().add_child(labelTimer)  # Add the timer to the SceneTree
	
	playerTimer = Timer.new()
	playerTimer.wait_time = 1.0
	playerTimer.one_shot = true
	playerTimer.connect("timeout", self, "_on_PlayerTimer_timeout")
	add_child(playerTimer)
	get_tree().get_root().add_child(playerTimer)  # Add the timer to the SceneTree
	
func finish_game() -> void:
	label.visible = true
	labelTimer.start()
	set_process(false)
	playerTimer.start()

	
	
# We can't directly connect the body_entered signal to the finish_game()

# function because the body_entered signal requires a callback with a `body`

# parameter.

# That's why we need this function.
func _on_FinishLine_body_entered(body):
	print(body)
	if "Player" in body.name:
		finish_game()
		
func _on_LabelTimer_timeout():
	get_tree().change_scene("res://Level2.tscn")

	# We ensure that the label is visible.
func _on_PlayerTimer_timeout():
	player.set_physics_process(false)

	









# We can't directly connect the body_entered signal to the finish_game()

# function because the body_entered signal requires a callback with a `body`

# parameter.

# That's why we need this function.







