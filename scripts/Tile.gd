extends Area2D

# is this the starting tile?
# a Base building will be placed here at the start of the game
export var startTile = false

# do we have a building on this tile?
var hasBuilding : bool = false

# can we place a building on this tile?
var canPlaceBuilding : bool = false

var tileType : int = Globals.tile_data.types.GRASS

# components
onready var highlight : Sprite = get_node("Highlight")
onready var buildingIcon : Sprite = get_node("BuildingIcon")

# called once when the node is initialized
func _ready ():
    # add the tile to the "Tiles" group when the node is initialized
    add_to_group("Tiles")
    set_type(tileType)

func set_type(type):
    tileType = type
    var type_tiles = Globals.tile_data.type_sprites[type]
    get_node('Ground').texture = type_tiles[randi() % len(type_tiles)]

# turns on or off the green highlight
func toggle_highlight (toggle):

    highlight.visible = toggle
    canPlaceBuilding = toggle

# called when a building is placed on the tile
# sets the tile's building texture to display it
func place_building (buildingTexture):

    hasBuilding = true
    buildingIcon.texture = buildingTexture

func grid_position():
    return Vector2(
        int(position.x) / 64,
        int(position.y) / 64
    )

# called when an input event takes place on the tile
func _on_Tile_input_event(viewport, event, shape_idx):

    # did we click on this tile with our mouse?
    if event is InputEventMouseButton and event.pressed:
        var gameManager = get_node("/root/MainScene")
        print(grid_position())
        # if we can place a building down on this tile, then do so
        if gameManager.currentlyPlacingBuilding and canPlaceBuilding:
            gameManager.place_building(self)
