class_name ItemRegistry
extends Node

@export var registry : Dictionary

func GetItem(key : Item) -> PackedScene:
    
    if not registry.has(key): return null
    
    return registry[key]
