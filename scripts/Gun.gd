extends MeshInstance3D

# Const variables
const bullet_speed_m := 5.0
const bullet_distance_m := 50
const bullet_comsumption := 10

# Variables
@onready var spawnPoint = $GunSpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
