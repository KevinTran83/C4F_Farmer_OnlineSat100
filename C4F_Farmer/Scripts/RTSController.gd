extends Node

var agent : NavigationAgent3D
@onready var movement : Movement = get_parent().get_node("Movement")

func _ready() -> void:
    agent = NavigationAgent3D.new()
    get_parent().add_child.call_deferred(agent)
