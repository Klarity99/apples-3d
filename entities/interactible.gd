extends Node3D
class_name Interactible

@onready var select_view := $View/Select
@onready var view := $View
@onready var interact_area := $InteractArea
@export var id: String
@export var type: String
@export var object: Node3D

func _ready() -> void:
	select_view.visible = false
	match id:
		"gem":
			Controls.level_gems += 1
	change()

func change():
	match id:
		"lever":
			var on := type == "on"
			$View/Pivot.rotation_degrees.x = -45 if on else 45
			$View/Base.mesh.material.albedo_color = Color.GREEN if on else Color.RED
			object.open(on)

func highlight(on: bool):
	select_view.visible = on
	
