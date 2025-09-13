class_name Farm
extends Node

@onready var inventory : Inventory = get_parent().get_node("Inventory")
@onready var registry : ItemRegistry = get_tree().get_root().get_node("Main").get_node("ItemRegistry")

func Plant(spawnPos : Vector3) -> void:
    var plant : PackedScene = registry.GetItem(inventory.UseItem())
    if not plant : return
    var newPlant : Node3D = plant.instantiate()
    get_parent().get_parent().add_child(newPlant)
    newPlant.set_global_position(spawnPos)

func Harvest(targetPlant : Plant) -> void:
    if not targetPlant.IsRipe() : return
    targetPlant.Drop()
    targetPlant.queue_free()
