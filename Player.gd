extends KinematicBody2D

var SPEED := 300.0
const BULLETSPEED = 1000
var bullet = preload("res://bullet.tscn")


signal potion_picked_up


var isPotionActive = false
const POTION_DURATION = 3.0
var potionTimer = Timer.new()

var health = 100 

onready var healthBar := get_node("/root/world/Control/CanvasLayer/ProgressBar")

onready var enemy := get_node("/root/world/Enemy")
signal PotionPickedUp

  # Replace "ProgressBar" with the actual path to your ProgressBar node

const DIRECTION_TO_FRAME := {
	Vector2.DOWN: 0,
	Vector2.DOWN + Vector2.RIGHT: 1,
	Vector2.RIGHT: 2,
	Vector2.UP + Vector2.RIGHT: 3,
	Vector2.UP: 4,
	}

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

	if isPotionActive:
		direction = Vector2.ZERO

	var velocity := direction * SPEED
	direction = direction.normalized()
	move_and_slide(velocity)
	look_at(get_global_mouse_position())

	Vector2.round()
	var direction_key := direction.round()
	direction_key.x = abs(direction.x)

func _ready():
	potionTimer.connect("timeout", self, "_on_PotionTimer_timeout")
	add_child(potionTimer)
	potionTimer.wait_time = POTION_DURATION
	potionTimer.one_shot = true

func fire_bullet():
	var bulletInstance = bullet.instance()

	bulletInstance.position = get_global_position()
	bulletInstance.rotation_degrees = rotation_degrees

	var direction = Vector2(1, 0).rotated(rotation)
	var velocity = direction.normalized() * BULLETSPEED

	bulletInstance.set_linear_velocity(velocity)

	get_tree().get_root().add_child(bulletInstance)

	bulletInstance.connect("body_entered", self, "_on_Bullet_body_entered")

	var bulletTimer = Timer.new()
	bulletTimer.wait_time = 1.0  # Set the bullet lifespan
	bulletTimer.one_shot = true
	bulletTimer.connect("timeout", bulletInstance, "queue_free")  # Delete the bullet instance

	bulletInstance.add_child(bulletTimer)  # Add the timer as a child of the bullet instance
	bulletTimer.start()

func kill():
	health = 0  # Reduce health to zero
	update_health_bar()
	get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		health -= 10
		update_health_bar()
	if health <= 0:
		kill()

func speed_boost(boostFactor: float, duration: float) -> void:
	SPEED *= boostFactor
	yield(get_tree().create_timer(duration), "timeout")
	SPEED /= boostFactor



func _on_PotionTimer_timeout() -> void:
	isPotionActive = false

func update_health_bar():
	healthBar.set_value(health)
	



#func _on_HealthPotion_body_entered(body):
#	if body.name == "Player":
#		var healthPotion = body as HealthPotion
#		health += healthPotion.healingAmount
#		update_health_bar()
#		healthPotion.queue_free()


func _on_InvisibilityPotion_body_entered(body):
	print("jk")
	if body.is_in_group("player"):
		print("in")
		emit_signal("potion_picked_up")

