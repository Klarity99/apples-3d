extends Node3D

@onready var object: Node3D = get_parent()
@onready var wait_timer: Timer = $WaitPeriod

@export var speed: float = 5.0
@export var wait_period: float = 0.0

var path: Array[Marker3D] = []
var path_index := 0
var waiting := false

func _ready() -> void:
	wait_timer.timeout.connect(_on_wait_timeout)

	for child in get_children():
		if child is Marker3D:
			path.append(child)

	if path.is_empty():
		push_warning("Flyer has no path markers")
		set_physics_process(false)

func _physics_process(delta: float) -> void:
	if waiting:
		_apply_movement(Vector3.ZERO, delta)
		return

	var target := path[path_index].global_position
	var to_target := target - object.global_position

	if to_target.length() < 0.02:
		_arrived()
		return

	var direction := to_target.normalized()
	var velocity := direction * speed

	_apply_movement(velocity, delta)

func _apply_movement(velocity: Vector3, delta: float) -> void:
	if object is CharacterBody3D:
		var body := object as CharacterBody3D
		body.velocity = velocity
		body.move_and_slide()
	else:
		object.global_position += velocity * delta

func _arrived() -> void:
	path_index = (path_index + 1) % path.size()

	if wait_period > 0.0:
		waiting = true
		wait_timer.start(wait_period)

func _on_wait_timeout() -> void:
	waiting = false
