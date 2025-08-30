class_name Seed
extends Node

@export var item : Item

func GetItem() -> Item:
    queue_free()
    return item
