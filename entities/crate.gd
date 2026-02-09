extends StaticBody3D

@onready var left_area := $Left 
@onready var top_area := $Top 
@onready var right_area := $Right 
@onready var bot_area := $Bot
var left := false 
var top := false 
var right := false 
var bot := false
var speed := 1.25

func _ready() -> void:
	left_area.body_entered.connect(left_in)
	left_area.body_exited.connect(left_out)
	top_area.body_entered.connect(top_in)
	top_area.body_exited.connect(top_out)
	right_area.body_entered.connect(right_in)
	right_area.body_exited.connect(right_out)
	bot_area.body_entered.connect(bot_in)
	bot_area.body_exited.connect(bot_out)

func _physics_process(delta: float) -> void:
	var input_dir := Vector3.ZERO
	if right and Input.is_action_pressed("left"):
		input_dir.x -= 1
	if left and Input.is_action_pressed("right"):
		input_dir.x += 1
	if bot and Input.is_action_pressed("up"):
		input_dir.z -= 1
	if top and Input.is_action_pressed("down"):
		input_dir.z += 1
	input_dir = input_dir.normalized()
	position += input_dir * delta * speed

func left_in(_body: Node3D):
	left = true
func left_out(_body: Node3D):
	left = false

func top_in(_body: Node3D):
	top = true
func top_out(_body: Node3D):
	top = false

func right_in(_body: Node3D):
	right = true
func right_out(_body: Node3D):
	right = false

func bot_in(_body: Node3D):
	bot = true
func bot_out(_body: Node3D):
	bot = false
