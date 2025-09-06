extends Control

@onready var itemList : ItemList = get_node("ItemList")

func UpdateItem(itemNo : int, item : Item, noItems : int) -> void:
    if itemNo < 0 or itemNo >= itemList.get_item_count():
        itemList.add_item(str(noItems), item.icon, true)
        return
    
    itemList.set_item_text(itemNo, str(noItems))
