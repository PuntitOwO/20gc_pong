class_name Ball
extends CharacterBody2D

@onready var base_direction = Vector2(1, 1).normalized()

const SPEED = 500

func _ready() -> void:
	compute_initial_velocity()

func compute_initial_velocity() -> void:
	var random_direction := randi() % 4 # random int [0, 3]
	var final_direction := base_direction.rotated(random_direction * TAU / 4)
	velocity = final_direction * SPEED

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision == null: return
	velocity = velocity.bounce(collision.get_normal())
