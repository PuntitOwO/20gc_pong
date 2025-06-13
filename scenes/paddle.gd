extends CharacterBody2D

@export_enum("left", "right") var paddle := "left"
@onready var up_action := paddle + "_paddle_up"
@onready var down_action := paddle + "_paddle_down"
var x :float

const SPEED := 500

func _ready() -> void:
	x = global_position.x

func _physics_process(_delta: float) -> void:
	var input = Input.get_axis(up_action, down_action)
	velocity.y = SPEED * input
	move_and_slide()
	# X coordinate fixing
	global_position.x = x
