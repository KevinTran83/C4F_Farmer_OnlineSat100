class_name PlantFrames
extends Resource

@export var sprite      : NodePath
@export var framesTotal : int = 1

var node3D : Node3D

func Start(parent : Node) -> void:
    node3D = parent.get_node(sprite)
    node3D.set_visible(true)

func Hide(parent : Node) -> void:
    node3D = parent.get_node(sprite)
    node3D.set_visible(false)

func HasFinished() -> bool:
    
    # Check if this is a sprite3D
    if not node3D is Sprite3D: return true
    
    # Check if this sprite has gone through all frames
    if node3D.get_frame() >= framesTotal - 1 : return true
    
    # Go to next frame
    node3D.set_frame(node3D.get_frame()+1)
    return false
