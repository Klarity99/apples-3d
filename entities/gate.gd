extends Node3D

@onready var left_door := $View/Left
@onready var right_door := $View/Right
@onready var static_body_collision := $StaticBody3D/CollisionShape3D
var opened := false

func open(on := true) -> void:
	if opened == on: return
	opened = on
	left_door.rotation_degrees.y = 90 if on else 0
	right_door.rotation_degrees.y = -90 if on else 0
	static_body_collision.disabled = on

