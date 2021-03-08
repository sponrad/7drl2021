extends Area2D

# is this the starting tile?
# a Base building will be placed here at the start of the game
export var startTile = false

# do we have a building on this tile?
var hasBuilding : bool = false

# can we place a building on this tile?
var canCastSpell : bool = false

var tileType : int = TileData.tile_types.SAND
var feature_type = null

# components
onready var highlight : Sprite = get_node("Highlight")
onready var featureIcon : Sprite = get_node("FeatureIcon")

# called once when the node is initialized
func _ready ():
    # add the tile to the "Tiles" group when the node is initialized
    z_index = -1
    add_to_group("Tiles")
    set_type(tileType)

func set_type(type):
    tileType = type
    var type_tiles = TileData.tile_type_sprites[type]
    get_node('Ground').texture = type_tiles[randi() % len(type_tiles)]

# turns on or off the green highlight
func toggle_highlight (toggle):
    highlight.visible = toggle
    canCastSpell = toggle

# called when a building is placed on the tile
# sets the tile's building texture to display it
func place_feature(new_type):
    hasBuilding = true
    feature_type = new_type
    var feature_sprites = TileData.feature_type_sprites[feature_type]
    featureIcon.texture = feature_sprites[randi() % len(feature_sprites)]


func grid_position():
    return Vector2(
        int(position.x) / 64,
        int(position.y) / 64
    )

# called when an input event takes place on the tile
func _on_Tile_input_event(_viewport, event, _shape_idx):
    # did we click on this tile with our mouse?
    if event is InputEventMouseButton and event.pressed:
        var gameManager = get_node("/root/MainScene")
        print(grid_position())
        if gameManager.currentlyCastingSpell and canCastSpell:
            gameManager.cast_spell(self)
