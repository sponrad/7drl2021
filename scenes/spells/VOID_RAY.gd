extends Area2D

var total_time = 0.0
onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.VOID_RAY
var start_pos = (Globals.wizard_start * 64.0) + Vector2(40, 24)
var end_pos: Vector2
var velocity = 1000
var direction: Vector2
var will_handle_end_of_turn = true
var enemy

# Called when the node enters the scene tree for the first time.
func _ready():
    var tile = game_manager.map.get_tile_at_position(position)
    end_pos = position
    direction = position - start_pos
    position = start_pos
    game_manager.set_paused(true)
    velocity = position.distance_to(end_pos)


func grid_position(pos):
    return Vector2(
        int(pos.x) / 64,
        int(pos.y) / 64
    )

func _draw():
    draw_line(start_pos - start_pos, end_pos - start_pos, Color(0, 0, 0), 10, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    $Sprite.position += direction.normalized() * velocity * delta
    # have to translate this back to global position instead of wizard
    var s_position = $Sprite.position + start_pos
    if grid_position(s_position) == grid_position(end_pos):
        var tile = game_manager.map.get_tile_at_coords(
            grid_position(s_position))
        var enemy = tile.has_enemy()
        if enemy:
            enemy.take_damage(
                SpellData.defs[spell].attack
            )
        game_manager.set_paused(false)
        game_manager.end_turn()
        queue_free()
