class_name Farm
extends Node

@onready var inventory : Inventory = get_parent().get_node("Inventory")

func Plant() -> void:
    inventory.UseItem()
