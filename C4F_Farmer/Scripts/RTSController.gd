extends Node

var agent : NavigationAgent3D
@onready var movement : Movement = get_parent().get_node("Movement")
@onready var farm     : Farm     = get_parent().get_node("Farm")
@export  var camera   : Camera3D
@onready var player   : CharacterBody3D = get_parent()

func _ready() -> void:
    agent = NavigationAgent3D.new()
    get_parent().add_child.call_deferred(agent)

func _process(_dt : float) -> void:
    if !agent.is_target_reached() :
            var nextPos : Vector3 = agent.get_next_path_position()
            var dir     : Vector3 = (nextPos - player.get_global_position()).normalized()
            movement.Move(dir)
    
func _input(event : InputEvent) -> void:
    if (event is InputEventMouseButton):
        if(event.get_button_index() == MOUSE_BUTTON_RIGHT):
            var query : Dictionary = mouseRaycast()
            if (!query.is_empty()):
                agent.set_target_position(query.position)
        if(event.get_button_index() == MOUSE_BUTTON_LEFT):
            var query : Dictionary = mouseRaycast()
            if (!query.is_empty()):
                farm.Plant(query.position)

func mouseRaycast() -> Dictionary:
    if !camera : return {}

    # Get mouse position and calculate ray positions.
    var mousePos : Vector2 = camera.get_viewport().get_mouse_position()
    var from     : Vector3 = camera.project_ray_origin(mousePos)
    var to       : Vector3 = from + camera.project_ray_normal(mousePos) * 100
    
    var rayQuery : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
    rayQuery.from = from
    rayQuery.to   = to

    var space     = camera.get_world_3d().get_direct_space_state()
    var rayResult : Dictionary = space.intersect_ray(rayQuery)
    if (!rayResult.position) : return {}
    return rayResult
