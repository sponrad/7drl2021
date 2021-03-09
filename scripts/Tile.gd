extends Area2D

# can we cast the current spell on this tile?
var can_target : bool = false
var tile_type : int = TileData.tile_types.SAND
var feature_type = null
var fog_of_war = false

# components
onready var highlight : Sprite = get_node("Highlight")
onready var featureIcon : Sprite = get_node("FeatureIcon")

onready var game_manager : Node = get_node("/root/MainScene")

# called once when the node is initialized
func _ready ():
    # add the tile to the "Tiles" group when the node is initialized
    z_index = -1
    add_to_group("Tiles")
    set_type(tile_type)

func set_type(type):
    tile_type = type
    var type_tiles = TileData.tile_type_sprites[type]
    get_node('Ground').texture = type_tiles[randi() % len(type_tiles)]

# turns on or off the green highlight
func toggle_highlight (toggle):
    highlight.visible = toggle
    can_target = toggle

func place_feature(new_type):
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
        print(grid_position())
        if game_manager.currently_casting_spell and can_target:
            game_manager.cast_spell(self)
        elif game_manager.current_summon \
            and game_manager.current_summon.position == position:
            game_manager.start_move_summon()
        elif game_manager.currently_moving_summon and can_target:
            game_manager.move_summon(self)

func get_power_per_turn():
    # for the enchant spell
    return TileData.feature_type_defs[feature_type]['power'] \
        + TileData.defs[tile_type]['power']

func show_tile_power(show):
    var power = get_power_per_turn()
    $PowerParent/TilePower.text = '+%s' % power
    if show:
        $PowerParent/TilePower.show()
    else:
        $PowerParent/TilePower.hide()

func has_enemy():
    for monster in get_tree().get_nodes_in_group("monsters"):
        if monster.grid_position() == grid_position():
            return monster
    return false

func is_moveable():
    if feature_type in [TileData.feature_types.ROCK_BROWN,
                                        TileData.feature_types.ROCK_GRAY]:
        return false
    return true
