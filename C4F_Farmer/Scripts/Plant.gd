class_name Plant
extends Node3D

@export var seed     : PackedScene
@export var ripeTime : float
@export var spriteSapling  : Sprite3D
@export var spriteSeedling : Sprite3D

var lifetime : float

signal onGrow(t : float)

func _ready() -> void : lifetime = 0

func _process(delta : float) -> void :
    lifetime += delta
    onGrow.emit(lifetime / ripeTime)

func IsRipe() -> bool : return lifetime >= ripeTime

func Drop() -> void:
    for i in randi_range(1,10):
        var newSeed = seed.instantiate()
        get_parent().add_child(newSeed)
        newSeed.set_global_position(global_position + Vector3(randf_range(-.1,.1),
                                                              0,
                                                              randf_range(-.1,.1)
                                                             ))
