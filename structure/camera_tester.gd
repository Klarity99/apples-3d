extends Node3D

@onready var cam: Camera3D = $Camera3D
@onready var target: Node3D = $Target
@onready var fov_slider: Slider = $FOVSlider
@onready var angle_slider: Slider = $AngleSlider

var default_distance: float = 10.0

func _ready():
	# initialize slider values
	fov_slider.value = cam.fov
	angle_slider.value = cam.rotation.x * 180.0 / PI

	# connect signals
	fov_slider.value_changed.connect(_on_slider_changed)
	angle_slider.value_changed.connect(_on_slider_changed)

	_update_camera()

func _on_slider_changed(value):
	_update_camera()

func _update_camera():
	var angle_rad := deg_to_rad(angle_slider.value)
	cam.rotation.x = angle_rad

	cam.fov = fov_slider.value

	var look_dir := cam.transform.basis.z.normalized()
	var offset := look_dir * default_distance / tan(deg_to_rad(cam.fov) * 0.5)
	cam.global_position = target.global_position + offset
