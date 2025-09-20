extends Node

@export var plantStages : Array[PlantFrames]

var totalFrames  : int
var currentPlant : int

func _ready() -> void:
    for plant in plantStages:
        totalFrames += plant.framesTotal
        plant.Hide(self)
    plantStages[currentPlant].Start(self)
        
func Animate(t : float) -> void:
    if currentPlant >= plantStages.size()-1 : return
    
    var newIndex : int = plantStages.size() * t
    if (currentPlant == newIndex) : return
    
    if not plantStages[currentPlant].HasFinished(): return
    
    plantStages[currentPlant].Hide(self)
    plantStages[newIndex    ].Start(self)
    currentPlant = newIndex
