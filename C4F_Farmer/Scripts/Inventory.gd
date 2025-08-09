class_name Inventory
extends Node

@export var inventory : Dictionary
@export var keys      : Array[Item]

var selectedIndex : int

func _ready() -> void : selectedIndex = 0

func UseItem() -> void:
    if selectedIndex < 0 :                return
    if selectedIndex > inventory.size() : return
    
    var key : Item = keys[selectedIndex]
    
    if inventory[key] <= 0 : return
    
    inventory[key] -= 1
    print("Items left : " + str(inventory[key]))
