extends Area2D

var total_time = 0.0
onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.ENCHANT_AREA

# Called when the node enters the scene tree for the first time.
func _ready():
    var tile = game_manager.map.get_tile_at_position(position)
    game_manager.add_to_power_per_turn(tile.get_power_per_turn())

func destroy(pos):
    # remove the power from the globals
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    total_time += delta
    modulate.a = 0.33 + (sin(3 * total_time) + 1) / 3
