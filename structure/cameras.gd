extends Node3D

@onready var cameras := get_children()
var camera_positions := []
var current_camera := 0
var step := 10

func _ready() -> void:
	Nodes.cameras = self
	for camera: Camera3D in cameras:
		camera_positions.append(camera.global_position)
	camera_change(current_camera)

func _input(_event: InputEvent):
	for i in cameras.size():
		if Input.is_action_pressed("key_" + str(i + 1)):
			camera_change(i)
			
func camera_change(index: int) -> void:
	if index >= cameras.size(): return
	cameras[index].current = true

func set_loc(loc):
	for i in cameras.size():
		var camera: Camera3D = cameras[i]
		camera.global_position.x = camera_positions[i].x + loc.x * (step * 3)
		camera.global_position.z = camera_positions[i].z + loc.y * (step * 2)
		
