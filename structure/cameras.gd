extends Node3D

@onready var cameras := get_children()
var current_camera := 0

func _ready() -> void:
	Nodes.cameras = self
	camera_change(current_camera)

func _input(_event: InputEvent):
	for i in cameras.size():
		if Input.is_action_pressed("key_" + str(i + 1)):
			camera_change(i)
			
func camera_change(index: int):
	cameras[index].current = true

func set_loc(loc):
	var camera: Camera3D = cameras[0]
	var step := 10
	camera.position.x = 0 + loc.x * (step * 3)
	camera.position.z = 30 + loc.y * (step * 2)
		
