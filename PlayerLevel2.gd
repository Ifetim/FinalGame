extends KinematicBody2D

var SPEED := 400.0
const BULLETSPEED = 1000
var bullet = preload("res://bullet.tscn")



var isPotionActive = false
const POTION_DURATION = 3.0
var potionTimer = Timer.new()

var health = 100 
var playerScore = 0 

onready var healthBar := get_node("/root/Level2/CanvasLayer/ProgressBar")
onready var enemy := get_node("/root/Level2/Enemy")
var enemyGroup = []

var bulletCooldown = 0.5  # Cooldown time between bullets
var bulletTimer = Timer.new()
var canShoot = true


var scoreTimer: Timer

  # Replace "ProgressBar" with the actual path to your ProgressBar node

const DIRECTION_TO_FRAME := {
	Vector2.DOWN: 0,
	Vector2.DOWN + Vector2.RIGHT: 1,
	Vector2.RIGHT: 2,
	Vector2.UP + Vector2.RIGHT: 3,
	Vector2.UP: 4,
	}

onready var sprite := $Godot
onready var label := get_node("/root/Level2/CanvasLayer/Label")

var enemyTouchTimer = Timer.new()
const ENEMY_TOUCH_DAMAGE_INTERVAL = 1.0

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
	
	enemyTouchTimer.wait_time = ENEMY_TOUCH_DAMAGE_INTERVAL
	enemyTouchTimer.one_shot = false
	enemyTouchTimer.connect("timeout", self, "_on_EnemyTouchTimer_timeout")
	add_child(enemyTouchTimer)
	
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemyGroup.append(enemy)
		enemy.connect("enemy_killed", self, "_increase_score")
		 # Pass the reference to the player's score

		
#	var bulletCooldown = 0.5  # Cooldown time between bullets
#	var bulletTimer = Timer.new()

	scoreTimer = Timer.new()
	add_child(scoreTimer)
	scoreTimer.wait_time = 1.0
	scoreTimer.connect("timeout", self, "_update_score")
	scoreTimer.start()




func fire_bullet():
	if  canShoot:
		var bulletInstance = bullet.instance()

		bulletInstance.position = get_global_position()
		bulletInstance.rotation_degrees = rotation_degrees

		var direction = Vector2(1, 0).rotated(rotation)
		var velocity = direction.normalized() * BULLETSPEED

		bulletInstance.set_linear_velocity(velocity)

		get_tree().get_root().add_child(bulletInstance)
		bulletInstance.connect("body_entered", self, "_on_Bullet_body_entered")

		
		var bulletTimer = Timer.new()
		bulletTimer.wait_time = bulletCooldown
		bulletTimer.one_shot = true
		bulletTimer.connect("timeout", self, "_on_BulletTimer_timeout", [bulletInstance])

		bulletInstance.add_child(bulletTimer)
		bulletTimer.start()

		canShoot = false
		
func _on_BulletTimer_timeout(bulletInstance):
	bulletInstance.queue_free()
	canShoot = true




func kill():
	health = 0  # Reduce health to zero
	update_health_bar()
	get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	print(body)
	if body.is_in_group("enemies"):
		health -= 5
		update_health_bar()
	if health <= 0:
		kill()
#	elif 
#		print("Touchestilemap")
#		# Ignore collision with the TileMap
#		return
		

func speed_boost(boostFactor: float, duration: float) -> void:
	SPEED *= boostFactor
	yield(get_tree().create_timer(duration), "timeout")
	SPEED /= boostFactor

func update_health_bar():
	healthBar.value = health

func _on_EnemyTouchTimer_timeout():
	if enemy.is_colliding():
		health -= 1
		update_health_bar()
		enemyTouchTimer.start() 

func _on_PotionTimer_timeout():
	isPotionActive = false
	

func _update_score():
	playerScore += 5  # Increase score by 1 for every second alive
	update_score_label()



func update_score_label():
	label.text = "Score: " + str(playerScore)
	# Add your code to update the score label UI here
	
func _increase_score():
	playerScore += 20  # Increase score by 10 when an enemy is killed
	update_score_label()




