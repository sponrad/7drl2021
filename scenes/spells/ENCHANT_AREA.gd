extends Area2D

var total_time = 0.0
onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.ENCHANT_AREA

# Called when the node enters the scene tree for the first time.
func _ready():
    var tile = game_manager.map.get_tile_at_position(position)
    for enchant in get_tree().get_nodes_in_group("ENCHANT_AREA"):
        if enchant.position == position:
            game_manager.get_node('Wizard').show_message('You cannot enchant the same tile twice')
            return
    # check if we've alreayd got an enchant going on that tile
    game_manager.add_to_power_per_turn(tile.get_power_per_turn())
    add_to_group('ENCHANT_AREA')

func destroy(pos):
    # remove the power from the globals
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    total_time += delta
    modulate.a = 0.33 + (sin(3 * total_time) + 1) / 3
