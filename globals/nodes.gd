extends Node

@onready var main: Node3D
@onready var game: Node3D
@onready var level: Node3D
@onready var entities: Node3D
@onready var player: Player
@onready var interface: Control
@onready var menu: Control
@onready var cameras: Node3D

func _ready() -> void:
	main = get_tree().root.get_node("Main")
	menu = main.get_node("Menu")
	game = main.get_node("Game")
#	level = game.get_child(0)
#	interface = game.get_node("Interface")
#	init_level()

func init_level():
	entities = level.get_node("Entities")
	player = entities.get_node("Player")
	
