extends Area2D

var total_time = 0.0
onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.FIRE_BOLT
var start_pos = (Globals.wizard_start * 64.0) + Vector2(32, 32)
var end_pos: Vector2
var velocity = 500
var direction: Vector2
var will_handle_end_of_turn = true

# Called when the node enters the scene tree for the first time.
func _ready():
    var tile = game_manager.map.get_tile_at_position(position)
    end_pos = position
    direction = position - start_pos
    rotation = direction.angle() - 0.5 * PI
    position = start_pos
    game_manager.set_paused(true)

func destroy(pos):
    # remove the power from the globals
    pass

func grid_position(pos):
    return Vector2(
        int(pos.x) / 64,
        int(pos.y) / 64
    )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += direction.normalized() * velocity * delta
    if grid_position(position) == grid_position(end_pos):
        var tile = game_manager.map.get_tile_at_coords(grid_position(position))
        var enemy = tile.has_enemy()
        if enemy:
            enemy.take_damage(
                SpellData.defs[SpellData.spells.FIRE_BOLT].attack
            )
        game_manager.set_paused(false)
        game_manager.end_turn()
        queue_free()
