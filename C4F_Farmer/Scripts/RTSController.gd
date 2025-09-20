extends Node

var agent : NavigationAgent3D
@onready var movement : Movement = get_parent().get_node("Movement")
@onready var farm     : Farm     = get_parent().get_node("Farm")
@export  var camera   : Camera3D
@onready var player   : CharacterBody3D = get_parent()
@onready var inventory : Inventory = get_parent().get_node("Inventory")

signal onNumberKeyPressed(no : int)

func _ready() -> void:
    agent = get_parent().get_node("NavigationAgent3D")
    agent.set_target_desired_distance(0.001)
    #get_parent().add_child.call_deferred(agent)
    onNumberKeyPressed.connect( get_tree().get_root().get_node("Main") \
                                          .get_node("InventoryHUD")    \
                                          .get_node("ItemList")
                                          .select
                              )

func _process(_dt : float) -> void:
    if !agent.is_target_reached() :
            var nextPos : Vector3 = agent.get_next_path_position()
            var dir     : Vector3 = (nextPos - player.get_global_position()).normalized()
            print("Player " + str(player.get_global_position()))
            print("Next   " + str(agent.get_next_path_position()))
            print(dir)
            movement.Move(dir)
    
func _unhandled_input(event : InputEvent) -> void:
    if (event is InputEventMouseButton and event.is_pressed()):
        if(event.get_button_index() == MOUSE_BUTTON_RIGHT):
            var query : Dictionary = mouseRaycast()
            if (!query.is_empty()):
                print("Hit    " + str(query.position))
                agent.set_target_position(query.position)
        if(event.get_button_index() == MOUSE_BUTTON_LEFT):
            var query : Dictionary = mouseRaycast()
            if (!query.is_empty()):
                var plant : Node3D = query.collider.get_parent()
                if   plant.is_in_group("Plant") : farm.Harvest(plant)
                elif plant.is_in_group("Seed")  : inventory.AddItem(plant.GetItem())
                else                            : farm.Plant(query.position)
    
    if (event is InputEventKey and event.is_pressed()):
        if event.keycode >= KEY_0 and event.keycode <= KEY_9:
            onNumberKeyPressed.emit(event.keycode - KEY_0 - 1)

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
