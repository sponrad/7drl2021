extends Sprite

var grasses = [
    preload("res://sprites/Kenney/Tile/medievalTile_57.png"),
    preload("res://sprites/Kenney/Tile/medievalTile_58.png")
]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    texture = grasses[randi() % (len(grasses))]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
