extends Area2D

var total_time = 0.0
onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.ROOTS

# Called when the node enters the scene tree for the first time.
func _ready():
    var tile = game_manager.map.get_tile_at_position(position)
    if tile.has_enemy():
        tile.has_enemy().awaken()
        tile.has_enemy().cannot_move = true
