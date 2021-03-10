extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    # get tiles in range and damage them
    for tile in game_manager.map.allTiles:
        if tile.grid_position().distance_to(
            Globals.position_to_grid(position)) < 2 \
            and tile.has_enemy():
                tile.has_enemy().take_damage(
                    SpellData.defs[SpellData.spells.LIGHTNING].attack
                )


#func _process(delta):
#    $Sprite.rotate(delta)

func _on_Timer_timeout():
    queue_free()
