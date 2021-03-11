extends Node2D

var total_time = 0.0
onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.ZAP
var start_pos = (Globals.wizard_start * 64.0) + Vector2(32, 32)
var end_pos: Vector2
var velocity = 1000
var direction: Vector2
var will_handle_end_of_turn = true

# Called when the node enters the scene tree for the first time.
func _ready():
    print('spawning a zap')
    set_process(false)

func activate():
    var tile = game_manager.map.get_tile_at_position(position)
    end_pos = position
    direction = position - start_pos
    rotation = direction.angle() - 0.5 * PI
    position = start_pos # start_pos is in global coords
    velocity = position.distance_to(end_pos) * 2
    print('end_pos: %s, start_pos: %s' % [end_pos, start_pos])
    show()
    set_process(true)

func grid_position(pos):
    return Vector2(
        int(pos.x) / 64,
        int(pos.y) / 64
    )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += direction.normalized() * velocity * delta
    var s_position = position
    if grid_position(s_position) == grid_position(end_pos):
        var tile = game_manager.map.get_tile_at_coords(grid_position(s_position))
        var enemy = tile.has_enemy()
        if enemy:
            enemy.take_damage(
                SpellData.defs[spell].attack
            )
        game_manager.set_paused(false)
        queue_free()
