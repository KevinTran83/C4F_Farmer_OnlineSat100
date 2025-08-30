class_name Inventory
extends Node

@export var inventory : Dictionary
@export var keys      : Array[Item]

var selectedIndex : int

func _ready() -> void : selectedIndex = 0

func UseItem() -> Item:
    if selectedIndex < 0 :                return null
    if selectedIndex > inventory.size() : return null
    
    var key : Item = keys[selectedIndex]
    
    if inventory[key] <= 0 : return null
    
    inventory[key] -= 1
    print("Items left : " + str(inventory[key]))
    
    return key

func AddItem(item : Item) -> void:
    if not keys.has(item) : keys.append(item)
    
    if not inventory.has(item): inventory[item] = 0
    inventory[item] += 1
    
