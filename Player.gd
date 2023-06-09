extends KinematicBody2D
const SPEED := 300.0
const BULLETSPEED = 1000
var bullet = preload("res://bullet.tscn")

const DIRECTION_TO_FRAME := {
	Vector2.DOWN: 0,
	Vector2.DOWN + Vector2.RIGHT: 1,
	Vector2.RIGHT: 2,
	Vector2.UP + Vector2.RIGHT: 3,
	Vector2.UP: 4,
}
# We need to get the Sprite node to change its frame and flip it horizontally.

onready var sprite := $Godot

func _physics_process(delta: float) -> void:

	var direction := Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x = 1.0
	
	elif Input.is_action_pressed("move_left"):
		direction.x = -1.0

	elif Input.is_action_pressed("move_up"):
		direction.y = -1.0
		
	elif Input.is_action_pressed("move_down"):
		direction.y = 1.0
		
	if Input.is_action_just_pressed("LMB"):
		fire_bullet()

		
		
	var velocity := direction * SPEED
	direction = direction.normalized()
	move_and_slide(velocity)
	look_at(get_global_mouse_position())
	
# The Vector2.round() function returns a new Vector2 with both the `x` and
	# `y` rounded out.
	Vector2.round()
	var direction_key := direction.round() 
# The abs() function makes negative numbers positive.

	direction_key.x = abs(direction.x)
	
# if direction_key in DIRECTION_TO_FRAME:
# 	sprite.frame = DIRECTION_TO_FRAME[direction_key]
# Notice how we directly assign the result of a comparison to 
#flip_h.

# The computer converts comparisons to either true or false, 
#which is

 # compatible with boolean variables like flip_h.
#	sprite.flip_h = sign(direction.x) == -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func fire_bullet():
	# Create a new instance of the bullet scene
	var bulletinstance = bullet.instance()
#
#	# Set the bullet's initial position to match the player's position
	bulletinstance.position = get_global_position()
#
#	# Set the bullet's rotation to match the player's rotation
	bulletinstance.rotation_degrees = rotation_degrees
	bulletinstance.apply_impulse(Vector2(),Vector2(BULLETSPEED,0).rotated(rotation))
	
#
#	# Calculate the direction vector based on the player's rotation
#	var direction = Vector2(0,-1).rotated(rotation)
#	var velocity = direction.normalized() * BULLETSPEED
#	# Apply the bullet's speed to the direction vector
#
#
#	# Set the bullet's velocity
#	bulletinstance.set_linear_velocity(velocity) 
#
#	# Add the bullet to the scene
	get_tree().get_root().add_child(bulletinstance)
#


func kill():
	position= Vector2(0,0)
	get_tree().reload_current_scene()




	

	 # Replace with function body.



func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
		
