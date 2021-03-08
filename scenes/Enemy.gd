extends Area2D


enum types {
    DEMON,
    MAGE,
    BLOB,
    SKELETON,
}
var typeTileMaps = {}
var type: int = types.SKELETON
var awake = false

# Called when the node enters the scene tree for the first time.
func _ready():
    typeTileMaps = {
        types.DEMON: $RedDemon,
        types.MAGE: $PurpleMage,
        types.BLOB: $BlueBlob,
        types.SKELETON: $OrangeSkel,
    }
    randomize()
    var chance = randi() % 100
    print(chance)
    if chance > 50 and chance < 75:
        type = types.BLOB
    elif chance >= 75 and chance < 95:
        type = types.DEMON
    elif chance >= 95:
        type = types.MAGE
    for tilemap in typeTileMaps.values():
        tilemap.hide()
    typeTileMaps[type].show()
    z_index = -1

func awaken():
    $AsleepText.hide()
    awake = true

func take_turn():
    pass

#func _process(delta):
#    pass
