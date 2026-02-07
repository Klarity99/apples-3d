extends Node3D

@onready var left_area := $Left
@onready var right_area := $Right
@export var left: Vector2i
@export var right: Vector2i
@onready var debug_plane := $DebugPlane

func _ready() -> void:
#	left_area.on_body_entered.connect(on_left_entered)
#	left_area.on_body_entered.connect(on_right_entered)
	left_area.body_exited.connect(on_left_exited)
	right_area.body_exited.connect(on_right_exited)
	debug_plane.queue_free()


func on_left_exited(_body: Node3D):
	Controls.set_loc(left)

func on_right_exited(_body: Node3D):
	Controls.set_loc(right)
