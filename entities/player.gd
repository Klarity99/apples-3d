extends CharacterBody3D
class_name Player

var speed := 6.0
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var reach_area: Area3D = $ReachArea
var in_reach := []
var interact_object
@onready var view: Node3D = $View

var carry: Node3D

func _ready() -> void:
	reach_area.area_entered.connect(on_reach_entered)
	reach_area.area_exited.connect(on_reach_exited)

func on_reach_entered(area: Area3D):
	in_reach.append(area.get_parent())
	check_interacts()
	
func on_reach_exited(area: Area3D):
	in_reach.erase(area.get_parent())
	check_interacts()
	
func check_interacts():
	if in_reach.is_empty():
		if interact_object:
			interact_object.highlight(false)
		interact_object = null
	else:
		if interact_object == null:
			interact_object = in_reach[0]
			interact_object.highlight(true)

func parse_interact():
	match interact_object.id:
		"lever":
			interact_object.type = "off" if interact_object.type == "on" else "on"
			interact_object.change()
		"gem":
			Controls.collect_gem()
			interact_object.queue_free()
		"key":
			var old_carry: Interactible = carry
			var new_carry: Interactible = interact_object
			if old_carry:
				old_carry.reparent(Nodes.entities)
				old_carry.global_position = new_carry.global_position
				carry.interact_area.get_child(0).disabled = false
				carry.highlight(true)
			carry = interact_object
			carry.reparent(view)
			carry.interact_area.get_child(0).disabled = true
			carry.global_position = global_position
			carry.highlight(false)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if interact_object:
			parse_interact()
	if not is_on_floor():
		velocity.y -= gravity * delta
		velocity.x = 0.0
		velocity.z = 0.0
	else:
		var input_dir := Vector3.ZERO
		if Input.is_action_pressed("left"):
			input_dir.x -= 1
		if Input.is_action_pressed("right"):
			input_dir.x += 1
		if Input.is_action_pressed("up"):
			input_dir.z -= 1
		if Input.is_action_pressed("down"):
			input_dir.z += 1
		input_dir = input_dir.normalized()
		velocity.y = 0.0
		velocity.x = input_dir.x * speed
		velocity.z = input_dir.z * speed
	move_and_slide()
