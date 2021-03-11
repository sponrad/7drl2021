extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    # get the four adjacent tiles and clear the fog at each
    game_manager.map.clear_fov_at_position(position, 1)
    var tile = game_manager.map.get_tile_at_position(position)
    if tile.has_enemy():
        tile.has_enemy().awaken()

func _process(delta):
    $Sprite.rotate(delta)

func _on_Timer_timeout():
    queue_free()
