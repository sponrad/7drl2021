extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    game_manager.current_summon = self

func move_to(target_tile):
    # if movable, then move there
    if target_tile.has_enemy():
        # do combat!
        # do damage taking
        # move into place if the enemy died
        position = target_tile.position
    elif target_tile.is_moveable():
        position = target_tile.position
    game_manager.end_turn()
