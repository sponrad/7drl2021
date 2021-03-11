extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    game_manager.wake_and_show_all()

func _on_Timer_timeout():
    # get the first monster and kill it
    for monster in get_tree().get_nodes_in_group("monsters"):
        monster.take_damage(10000)
        return
