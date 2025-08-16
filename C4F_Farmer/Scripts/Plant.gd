extends Node3D

@export var seed : PackedScene

func Drop() -> void:
    for i in randi_range(1,10):
        var newSeed = seed.instantiate()
        get_parent().add_child(newSeed)
        newSeed.set_global_position(global_position + Vector3(randf_range(-.1,.1),
                                                              0,
                                                              randf_range(-.1,.1)
                                                             ))
