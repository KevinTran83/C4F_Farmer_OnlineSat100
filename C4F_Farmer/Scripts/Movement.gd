class_name Movement
extends Node

@onready var c3d : CharacterBody3D = get_parent()
@export var speed : float = 0.5

func Move(dir : Vector3) -> void:
    c3d.set_velocity(dir * speed)
    c3d.move_and_slide()
