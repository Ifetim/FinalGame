extends Node2D

const ROCKS := [
	preload("res://HealthPotion.tscn"),
	preload("res://Invisibility.tscn"),
	preload("res://new scene.tscn")
]

onready var mask: TileMap = $TileMap2

func _ready() -> void:
	add_rocks_on_grid()
	# We hide the mask tiles; otherwise, we will get an unwanted shade on the game level.
	mask.visible = false
	randomize()

func get_random_rock() -> Sprite:
	var rock_random_index := randi() % ROCKS.size()
	return ROCKS[rock_random_index].instance()

func add_rocks_on_grid() -> void:
	for cell in mask.get_used_cells():
		var rock := get_random_rock()
		add_child(rock)
		
		var rock_size := rock.scale * rock.texture.get_size()
		
		var available_space := mask.cell_size - rock_size
		var random_offset := Vector2(randf(), randf()) * available_space
		#rock.position = mask.position + mask.map_to_world(cell) #+ random_offset
		rock.position = mask.map_to_world(cell)
		print(cell)
		print(rock.position)
	
