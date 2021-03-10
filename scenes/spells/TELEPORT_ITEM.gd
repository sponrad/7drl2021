extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    var tile = game_manager.map.get_tile_at_position(position)
    var item = tile.has_item()
    if item:
        item.gain_item()


func _on_Timer_timeout():
    queue_free()
