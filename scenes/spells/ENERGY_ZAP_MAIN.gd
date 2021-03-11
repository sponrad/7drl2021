extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var index = 0
var zaps = []
onready var game_manager : Node = get_node("/root/MainScene")
var click_position

# Called when the node enters the scene tree for the first time.
func _ready():
    game_manager.set_paused(true)
    zaps = [$zap1, $zap2, $zap3]
    click_position = position
    # move this to the origin for child math to be easier
    position = Vector2(0, 0)

func _on_Timer_timeout():
    zaps[index].position = click_position
    zaps[index].activate()
    index +=1
    if index >= len(zaps):
        $Timer.stop()
        $endTimer.start()
        return

func _on_endTimer_timeout():
    game_manager.set_paused(false)
    game_manager.end_turn()
    queue_free()
