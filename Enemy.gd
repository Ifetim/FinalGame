extends KinematicBody2D
var motion = Vector2()



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	position += (Player.position - position)/70
	
	look_at(Player.position)
	
	move_and_collide(motion)
	
	


func _on_Area2D_body_entered(body):
	if 'bullet' in body.name:
		queue_free()
	 # Replace with function body.