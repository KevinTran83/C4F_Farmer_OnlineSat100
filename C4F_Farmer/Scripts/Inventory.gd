class_name Inventory
extends Node

@export var inventory : Dictionary
@export var keys      : Array[Item]

var selectedIndex : int

signal onItemAdd(itemNo : int, item : Item, noItems : int)
signal onItemUse(itemNo : int, item : Item, noItems : int)

func _ready() -> void:
    selectedIndex = 0
    get_tree().get_root().get_node("Main")         \
                         .get_node("InventoryHUD") \
                         .get_node("ItemList")     \
                         .item_selected.connect(SelectItem)

func UseItem() -> Item:
    if selectedIndex < 0 :                 return null
    if selectedIndex >= inventory.size() : return null
    
    var key : Item = keys[selectedIndex]
    
    if inventory[key] <= 0 : return null
    
    inventory[key] -= 1
    onItemUse.emit(selectedIndex, key, inventory[key])
    
    return key

func AddItem(item : Item) -> void:
    var itemNo : int = 0
    if not keys.has(item) :
        keys.append(item)
        itemNo = keys.size() - 1
    else : itemNo = keys.find(item)
    
    if not inventory.has(item): inventory[item] = 0
    inventory[item] += 1
    
    onItemAdd.emit(itemNo, item, inventory[item])

func SelectItem(index : int) -> void:
    selectedIndex = clamp(index, 0, keys.size() - 1)
